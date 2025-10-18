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

/// A helper class to hold a complete workout session, including the parent
/// session object and a list of all the set entries that belong to it.
class FullWorkoutSession {
  final Session session;
  final List<SetEntry> sets;

  FullWorkoutSession({required this.session, required this.sets});
}

// -----------------------------------------------------------------------------
// --- TABLE DEFINITIONS -------------------------------------------------------
// -----------------------------------------------------------------------------

// --- EXISTING WORKOUT HISTORY TABLES ---

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
  TextColumn get exerciseName => text()();
  IntColumn get setOrder => integer()();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

// --- NEW DXG TABLE ---

/// Persists a canonical exercise the first time it is used.
/// This table stores the generated slug, display name, and the discriminators
/// that were used to create it, linking it back to a movement family.
@DataClassName('ExerciseInstance')
class ExerciseInstances extends Table {
  /// The stable, unique slug, e.g., "press.dumbbell.incline.bilateral.supine".
  TextColumn get slug => text()();

  /// The ID of the parent movement family, e.g., "press".
  TextColumn get familyId => text().named('family_id')();

  /// The generated human-readable name, e.g., "Incline Dumbbell Press".
  TextColumn get displayName => text().named('display_name')();

  /// A JSON string representation of the map of discriminators.
  /// Uses a TypeConverter to handle serialization.
  TextColumn get discriminators =>
      text().map(const DiscriminatorsConverter())();

  /// The timestamp of when this exercise was first created/logged.
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
  ExerciseInstances, // Add the new table here
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  // --- MIGRATION STEP ---
  // The schema version must be incremented whenever the database structure
  // changes (e.g., adding a new table or column).
  int get schemaVersion => 2;

  /// Queries the database to retrieve all sessions and their associated sets.
  Future<List<FullWorkoutSession>> getWorkoutHistory() async {
    final query = select(sessions).join([
      innerJoin(setEntries, setEntries.sessionId.equalsExp(sessions.id)),
    ]);
    query.orderBy([OrderingTerm.desc(sessions.sessionDateTime)]);

    final rows = await query.get();

    final groupedData = groupBy(
      rows,
      (row) => row.readTable(sessions),
    );

    final result = groupedData.entries.map((entry) {
      final session = entry.key;
      final sets = entry.value.map((row) => row.readTable(setEntries)).toList();
      return FullWorkoutSession(session: session, sets: sets);
    }).toList();

    return result;
  }

  /// Deletes a session and all of its associated set entries from the database.
  /// This is done in a transaction to ensure data integrity.
  Future<void> deleteWorkoutSession(String sessionId) async {
    await transaction(() async {
      // Delete the sets associated with the session first.
      await (delete(setEntries)..where((tbl) => tbl.sessionId.equals(sessionId)))
          .go();
      // Then, delete the parent session record.
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