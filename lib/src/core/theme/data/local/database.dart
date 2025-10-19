// ----- lib/src/core/theme/data/local/database.dart -----
// lib/src/core/theme/data/local/database.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart'; // For groupBy
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fairware_lift/src/features/dxg/domain/exercise_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// -----------------------------------------------------------------------------
// --- DATA CLASS FOR HISTORY --------------------------------------------------
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
  // --- NEW COLUMN ---
  IntColumn get totalActivitySeconds =>
      integer().named('total_activity_seconds').nullable()();
  IntColumn get totalRestSeconds =>
      integer().named('total_rest_seconds').nullable()();
  TextColumn get notes => text().nullable()();
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
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
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
  int get schemaVersion => 6;

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
      },
    );
  }

  Future<List<FullWorkoutSession>> getWorkoutHistory() async {
    final sessionsResult = await (select(sessions)
          ..orderBy([(t) => OrderingTerm.desc(t.sessionDateTime)]))
        .get();

    final sessionIds = sessionsResult.map((s) => s.id).toList();
    if (sessionIds.isEmpty) return [];

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
  return AppDatabase();
});