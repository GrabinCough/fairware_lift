// lib/src/core/theme/data/local/database.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart'; // For groupBy

part 'database.g.dart';

// -----------------------------------------------------------------------------
// --- NEW DATA CLASS FOR HISTORY ----------------------------------------------
// -----------------------------------------------------------------------------

/// A helper class to hold a complete workout session, including the parent
/// session object and a list of all the set entries that belong to it.
class FullWorkoutSession {
  final Session session;
  final List<SetEntry> sets;

  FullWorkoutSession({required this.session, required this.sets});
}

// -----------------------------------------------------------------------------
// --- TABLE DEFINITIONS (from SSOT 6.1) ---------------------------------------
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
  TextColumn get exerciseName => text()();
  IntColumn get setOrder => integer()();
  RealColumn get weight => real()();
  IntColumn get reps => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

// -----------------------------------------------------------------------------
// --- DATABASE CLASS ----------------------------------------------------------
// -----------------------------------------------------------------------------

@DriftDatabase(tables: [Sessions, SetEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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

  /// --- NEW METHOD ---
  /// Deletes a session and all of its associated set entries from the database.
  /// This is done in a transaction to ensure data integrity.
  Future<void> deleteWorkoutSession(String sessionId) async {
    await transaction(() async {
      // Delete the sets associated with the session first.
      await (delete(setEntries)..where((tbl) => tbl.sessionId.equals(sessionId))).go();
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