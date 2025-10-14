// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Riverpod for creating a provider.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE DOMAIN MODEL ---------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple data model for a single exercise definition.
class Exercise {
  final String id;
  final String name;

  const Exercise({required this.id, required this.name});
}

// -----------------------------------------------------------------------------
// --- MOCK REPOSITORY ---------------------------------------------------------
// -----------------------------------------------------------------------------

/// A mock repository that provides a hardcoded list of exercises.
///
/// In a real application, this class would be responsible for fetching exercise
/// data from a local database (like Drift) or a remote server (like Firestore).
/// For now, it just returns a static list for UI development purposes.
class MockExerciseRepository {
  /// A static list of common exercises to populate our picker.
  static const List<Exercise> _exercises = [
    Exercise(id: 'ex_01', name: 'Barbell Bench Press'),
    Exercise(id: 'ex_02', name: 'Incline Dumbbell Press'),
    Exercise(id: 'ex_03', name: 'Overhead Press'),
    Exercise(id: 'ex_04', name: 'Tricep Pushdown'),
    Exercise(id: 'ex_05', name: 'Squat'),
    Exercise(id: 'ex_06', name: 'Deadlift'),
    Exercise(id: 'ex_07', name: 'Leg Press'),
    Exercise(id: 'ex_08', name: 'Leg Curl'),
    Exercise(id: 'ex_09', name: 'Leg Extension'),
    Exercise(id: 'ex_10', name: 'Pull Up'),
    Exercise(id: 'ex_11', name: 'Lat Pulldown'),
    Exercise(id: 'ex_12', name: 'Barbell Row'),
    Exercise(id: 'ex_13', name: 'Dumbbell Curl'),
    Exercise(id: 'ex_14', name: 'Lateral Raise'),
  ];

  /// Returns the full list of available exercises.
  List<Exercise> getExercises() {
    // In a real app, this would be an async call (e.g., `Future<List<Exercise>>`).
    return _exercises;
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A Riverpod provider that creates and exposes an instance of our repository.
/// The UI will use this provider to access the list of exercises.
final exerciseRepositoryProvider = Provider<MockExerciseRepository>((ref) {
  return MockExerciseRepository();
});