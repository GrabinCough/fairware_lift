// lib/src/features/exercises/data/exercise_repository.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// --- FIX ---
// Added this import for the `debugPrint` function.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

// Riverpod for creating a provider.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The CSV parsing package.
import 'package:csv/csv.dart';

// The Exercise data model we created.
import '../domain/exercise.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE REPOSITORY CLASS -----------------------------------------------
// -----------------------------------------------------------------------------

/// A repository responsible for loading and providing the master list of exercises.
///
/// This class handles the one-time operation of reading the exercise library
/// from the CSV asset file, parsing it, and storing it in memory for the
/// duration of the app's lifecycle.
class ExerciseRepository {
  /// The in-memory cache of all exercises after they have been loaded.
  final List<Exercise> exercises;

  ExerciseRepository({required this.exercises});

  /// A factory constructor to create an instance of the repository by
  /// asynchronously loading and parsing the exercise data from the CSV asset.
  static Future<ExerciseRepository> create() async {
    final rawCsv = await rootBundle.loadString('assets/data/fairware_exercise_library.csv');

    // This parsing logic is now more robust. It uses `eol: '\n'` to correctly
    // handle line endings and includes a safer loop to build the list.
    final List<List<dynamic>> rows = const CsvToListConverter(eol: '\n').convert(
      rawCsv,
      shouldParseNumbers: false,
    );

    final List<Exercise> exercises = [];
    // Start loop at 1 to explicitly skip the header row.
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];

      // A safety check to ensure the row has the correct number of columns
      // and is not just an empty line at the end of the file.
      if (row.length == 6 && row.any((cell) => cell.toString().trim().isNotEmpty)) {
        try {
          exercises.add(Exercise.fromCsvRow(row));
        } catch (e) {
          // This will help us debug if a specific row is malformed.
          debugPrint('Error parsing CSV row $i: $row. Error: $e');
        }
      }
    }

    return ExerciseRepository(exercises: exercises);
  }

  /// Returns the complete list of all available exercises.
  List<Exercise> getAllExercises() {
    return exercises;
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A Riverpod provider that creates and exposes a single, app-wide instance
/// of the [ExerciseRepository].
///
/// Using a `FutureProvider` allows us to handle the initial asynchronous
/// loading of the CSV file. The UI can then easily show a loading state while
/// the data is being prepared and an error state if the file fails to load.
final exerciseRepositoryProvider = FutureProvider<ExerciseRepository>((ref) async {
  return await ExerciseRepository.create();
});