// lib/src/core/theme/data/local/database.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Drift library for database operations.
import 'package:drift/drift.dart';

// Provides `Isar` for the underlying database engine on mobile.
import 'package:drift/native.dart';

// Path provider for finding the correct database file location.
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Dart's IO library for file system operations.
import 'dart:io';

// Riverpod for creating a global provider for our database.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------------------------
// --- DRIFT PART DIRECTIVE ----------------------------------------------------
// -----------------------------------------------------------------------------

// This is required by Drift's code generator. It will generate the file
// `database.g.dart` which contains the actual implementation of the database.
part 'database.g.dart';

// -----------------------------------------------------------------------------
// --- TABLE DEFINITIONS (from SSOT 6.1) ---------------------------------------
// -----------------------------------------------------------------------------

/// Defines the `sessions` table in the local database.
///
/// This table stores a record for each workout session the user completes.
/// The fields are based on the `Session` entity from the SSOT. For now, we are
/// implementing a subset of fields relevant to saving a basic workout.
@DataClassName('Session')
class Sessions extends Table {
  // A unique ID for the session, which will serve as the primary key.
  TextColumn get id => text()();

  // --- FIX ---
  // The getter for the session's date and time has been renamed from `dateTime`
  // to `sessionDateTime` to avoid a name conflict with the `dateTime()` method
  // inherited from Drift's `Table` class. The `.named('date_time')` call
  // ensures the actual column name in the database remains `date_time`.
  DateTimeColumn get sessionDateTime => dateTime().named('date_time')();

  // A general notes field for the session.
  TextColumn get notes => text().nullable()();
  // Timestamps for creation and updates.
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Defines the `set_entries` table in the local database.
///
/// This table stores every single set the user logs. Each row is linked to a
/// parent `Session` and contains the performance data for that set.
/// The fields are based on the `SetEntry` entity from the SSOT.
@DataClassName('SetEntry')
class SetEntries extends Table {
  // A unique ID for this specific set entry.
  TextColumn get id => text()();
  // A foreign key linking this set back to the parent `sessions` table.
  TextColumn get sessionId => text().references(Sessions, #id)();
  // For simplicity in a "Quick Workout", we'll store the exercise name directly.
  // In a full program, this would likely be a foreign key to an `exercises` table.
  TextColumn get exerciseName => text()();
  // The order of this set within the exercise (e.g., 1st set, 2nd set).
  IntColumn get setOrder => integer()();
  // The weight used for the set.
  RealColumn get weight => real()();
  // The number of repetitions performed.
  IntColumn get reps => integer()();
  // Timestamps for creation and updates.
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// -----------------------------------------------------------------------------
// --- DATABASE CLASS ----------------------------------------------------------
// -----------------------------------------------------------------------------

/// The main database class for the application.
///
/// Drift will use this class to generate all the necessary code for queries,
/// table creation, and data manipulation. The annotation specifies which tables
/// are part of this database.
@DriftDatabase(tables: [Sessions, SetEntries])
class AppDatabase extends _$AppDatabase {
  // The constructor takes the database executor as an argument.
  AppDatabase() : super(_openConnection());

  // This schema version is used for migrations. When you change your table
  // definitions, you must increment this number.
  @override
  int get schemaVersion => 1;
}

/// A private helper function to create the database connection.
///
/// This function determines the correct location for the database file on the
/// device's file system and opens a connection to it.
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

/// A Riverpod provider that creates and exposes a single, app-wide instance
/// of the [AppDatabase].
///
/// This allows other parts of the app (like repositories or state notifiers)
/// to easily access the database without needing to instantiate it manually.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});