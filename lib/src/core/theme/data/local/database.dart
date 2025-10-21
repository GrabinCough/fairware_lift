// lib/src/core/theme/data/local/database.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fairware_lift/src/features/dxg/domain/exercise_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// -----------------------------------------------------------------------------
// --- DATA CLASSES FOR QUERIES ------------------------------------------------
// -----------------------------------------------------------------------------

class FullWorkoutSession {
  final Session session;
  final List<SetEntryWithExercise> sets;
  final List<SavedWarmup> warmups;

  FullWorkoutSession({
    required this.session,
    required this.sets,
    required this.warmups,
  });
}

class SetEntryWithExercise {
  final SetEntry set;
  final ExerciseInstance exercise;

  SetEntryWithExercise({required this.set, required this.exercise});
}

// -----------------------------------------------------------------------------
// --- TABLE DEFINITIONS -------------------------------------------------------
// -----------------------------------------------------------------------------

@DataClassName('Session')
class Sessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get sessionDateTime => dateTime().named('date_time')();
  IntColumn get totalDurationSeconds =>
      integer().named('total_duration_seconds').nullable()();
  IntColumn get totalActivitySeconds =>
      integer().named('total_activity_seconds').nullable()();
  IntColumn get totalRestSeconds =>
      integer().named('total_rest_seconds').nullable()();
  TextColumn get notes => text().named('notes').nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SetEntry')
class SetEntries extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get exerciseSlug =>
      text().references(ExerciseInstances, #slug).named('exercise_slug')();
  IntColumn get setOrder => integer()();
  
  // Original weight/reps columns (kept for backward compatibility)
  RealColumn get weight => real()();
  IntColumn get reps => integer()();

  // --- NEW HYBRID SCHEMA COLUMNS ---
  TextColumn get setType => text().named('set_type').nullable()();
  IntColumn get durationSeconds => integer().named('duration_seconds').nullable()();
  IntColumn get distanceM => integer().named('distance_m').nullable()();
  IntColumn get calories => integer().named('calories').nullable()();
  RealColumn get rpe => real().named('rpe').nullable()();
  TextColumn get metricsJson => text().named('metrics_json').nullable()();
  TextColumn get prescriptionJson => text().named('prescription_json').nullable()();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseInstance')
class ExerciseInstances extends Table {
  TextColumn get slug => text()();
  TextColumn get familyId => text().named('family_id')();
  TextColumn get displayName => text().named('display_name')();
  TextColumn get discriminators =>
      text().map(const DiscriminatorsConverter())();
  DateTimeColumn get firstSeenAt => dateTime().named('first_seen_at')();
  @override
  Set<Column> get primaryKey => {slug};
}

@DataClassName('SavedWarmup')
class SavedWarmups extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get warmupId => text().named('warmup_id')();
  TextColumn get displayName => text().named('display_name')();
  TextColumn get parameters => text().map(const DiscriminatorsConverter())();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

// -----------------------------------------------------------------------------
// --- DATABASE CLASS ----------------------------------------------------------
// -----------------------------------------------------------------------------

@DriftDatabase(tables: [
  Sessions,
  SetEntries,
  ExerciseInstances,
  SavedWarmups,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: (migrator, from, to) async {
        if (from < 5) {
          await migrator.addColumn(sessions, sessions.totalDurationSeconds);
          await migrator.addColumn(sessions, sessions.totalRestSeconds);
        }
        if (from < 6) {
          await migrator.addColumn(sessions, sessions.totalActivitySeconds);
        }
        if (from < 7) {
          await migrator.addColumn(setEntries, setEntries.setType);
          await migrator.addColumn(setEntries, setEntries.durationSeconds);
          await migrator.addColumn(setEntries, setEntries.distanceM);
          await migrator.addColumn(setEntries, setEntries.calories);
          await migrator.addColumn(setEntries, setEntries.rpe);
          await migrator.addColumn(setEntries, setEntries.metricsJson);
          await migrator.addColumn(setEntries, setEntries.prescriptionJson);
          
          await customStatement('CREATE INDEX IF NOT EXISTS idx_setentries_set_type ON set_entries(set_type);');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_setentries_duration_seconds ON set_entries(duration_seconds);');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_setentries_distance_m ON set_entries(distance_m);');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_setentries_calories ON set_entries(calories);');
        }
      },
    );
  }

  Future<FullWorkoutSession?> getLatestWorkout() async {
    final latestSessionQuery = select(sessions)
      ..orderBy([(t) => OrderingTerm.desc(t.sessionDateTime)])
      ..limit(1);

    final sessionResult = await latestSessionQuery.getSingleOrNull();

    if (sessionResult == null) {
      return null;
    }

    final history = await getWorkoutHistory(limit: 1);
    return history.isNotEmpty ? history.first : null;
  }

  Future<List<FullWorkoutSession>> getWorkoutHistory({int? limit}) async {
    final query = select(sessions)
      ..orderBy([(t) => OrderingTerm.desc(t.sessionDateTime)]);

    if (limit != null) {
      query.limit(limit);
    }

    final sessionsResult = await query.get();
    if (sessionsResult.isEmpty) return [];

    final sessionIds = sessionsResult.map((s) => s.id).toList();

    final setsQuery = select(setEntries).join([
      innerJoin(exerciseInstances,
          exerciseInstances.slug.equalsExp(setEntries.exerciseSlug)),
    ])
      ..where(setEntries.sessionId.isIn(sessionIds));

    final warmupsQuery =
        select(savedWarmups)..where((tbl) => tbl.sessionId.isIn(sessionIds));

    final setsResult = await setsQuery.get();
    final warmupsResult = await warmupsQuery.get();

    final setsBySession =
        groupBy(setsResult, (row) => row.readTable(setEntries).sessionId);
    final warmupsBySession =
        groupBy(warmupsResult, (warmup) => warmup.sessionId);

    return sessionsResult.map((session) {
      final setsForSession = setsBySession[session.id] ?? [];
      final setsWithExercise = setsForSession.map((row) {
        return SetEntryWithExercise(
          set: row.readTable(setEntries),
          exercise: row.readTable(exerciseInstances),
        );
      }).toList();

      final warmupsForSession = warmupsBySession[session.id] ?? [];

      return FullWorkoutSession(
        session: session,
        sets: setsWithExercise,
        warmups: warmupsForSession,
      );
    }).toList();
  }

  Future<void> deleteWorkoutSession(String sessionId) async {
    await transaction(() async {
      await (delete(savedWarmups)..where((tbl) => tbl.sessionId.equals(sessionId)))
          .go();
      await (delete(setEntries)..where((tbl) => tbl.sessionId.equals(sessionId)))
          .go();
      await (delete(sessions)..where((tbl) => tbl.id.equals(sessionId))).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fairware_lift.db'));
    return NativeDatabase(file);
  });
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});