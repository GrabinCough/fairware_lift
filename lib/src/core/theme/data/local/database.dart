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

/// A helper class to hold a complete workout session.
class FullWorkoutSession {
  final Session session;
  final List<SetEntryWithExercise> sets;

  FullWorkoutSession({required this.session, required this.sets});
}

/// A helper class to hold a set entry joined with its exercise display name.
class SetEntryWithExercise {
  final SetEntry set;
  final String exerciseDisplayName;

  SetEntryWithExercise({required this.set, required this.exerciseDisplayName});
}

// -----------------------------------------------------------------------------
// --- TABLE DEFINITIONS -------------------------------------------------------
// -----------------------------------------------------------------------------

@DataClassName('Session')
class Sessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get sessionDateTime => dateTime().named('date_time')();
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

// -----------------------------------------------------------------------------
// --- DATABASE CLASS ----------------------------------------------------------
// -----------------------------------------------------------------------------

@DriftDatabase(tables: [
  Sessions,
  SetEntries,
  ExerciseInstances,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        // --- MIGRATION FIX ---
        // The correct method to delete all data from a table is `deleteTable`.
        await migrator.deleteTable('sessions');
        await migrator.deleteTable('set_entries');
        await migrator.deleteTable('exercise_instances');
        await migrator.createAll();
      },
    );
  }

  /// Queries the database to retrieve all sessions and their associated sets.
  Future<List<FullWorkoutSession>> getWorkoutHistory() async {
    final query = select(sessions).join([
      innerJoin(setEntries, setEntries.sessionId.equalsExp(sessions.id)),
      innerJoin(exerciseInstances,
          exerciseInstances.slug.equalsExp(setEntries.exerciseSlug)),
    ]);
    query.orderBy([OrderingTerm.desc(sessions.sessionDateTime)]);

    final rows = await query.get();

    final groupedData = groupBy(
      rows,
      (row) => row.readTable(sessions),
    );

    final result = groupedData.entries.map((entry) {
      final session = entry.key;
      final setsWithExercise = entry.value.map((row) {
        return SetEntryWithExercise(
          set: row.readTable(setEntries),
          exerciseDisplayName: row.readTable(exerciseInstances).displayName,
        );
      }).toList();
      return FullWorkoutSession(session: session, sets: setsWithExercise);
    }).toList();

    return result;
  }

  /// Deletes a session and all of its associated set entries from the database.
  Future<void> deleteWorkoutSession(String sessionId) async {
    await transaction(() async {
      await (delete(setEntries)..where((tbl) => tbl.sessionId.equals(sessionId)))
          .go();
      await (delete(sessions)..where((tbl) => tbl.id.equals(sessionId))).go();
    });
  }
}

/// A private helper function to create the database connection.
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