// lib/src/features/exercises/data/exercise_repository.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:csv/csv.dart';
import '../domain/exercise.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE REPOSITORY CLASS -----------------------------------------------
// -----------------------------------------------------------------------------

/// A repository responsible for loading and providing the master list of exercises.
class ExerciseRepository {
  final List<Exercise> exercises;

  ExerciseRepository({required this.exercises});

  static Future<ExerciseRepository> create() async {
    final rawCsv = await rootBundle.loadString('assets/data/fairware_exercise_library.csv');

    final List<List<dynamic>> rows = const CsvToListConverter(eol: '\n').convert(
      rawCsv,
      shouldParseNumbers: false,
    );

    final List<Exercise> exercises = [];
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length >= 6 && row.any((cell) => cell.toString().trim().isNotEmpty)) {
        try {
          exercises.add(Exercise.fromCsvRow(row));
        } catch (e) {
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

  /// --- NEW METHOD ---
  /// Extracts all unique primary muscle groups from the exercise list.
  /// This is used to populate the filter chips in the UI.
  List<String> getUniquePrimaryMuscles() {
    // Use a Set to automatically handle uniqueness.
    final Set<String> muscleSet = {};
    for (final exercise in exercises) {
      // Split muscles that might be comma-separated and add them individually.
      final muscles = exercise.primaryMuscles.split(',').map((e) => e.trim());
      muscleSet.addAll(muscles);
    }
    // Convert the Set to a List and sort it alphabetically.
    final muscleList = muscleSet.toList();
    muscleList.sort();
    return muscleList;
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final exerciseRepositoryProvider = FutureProvider<ExerciseRepository>((ref) async {
  return await ExerciseRepository.create();
});