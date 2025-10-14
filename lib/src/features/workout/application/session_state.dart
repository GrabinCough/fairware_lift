// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Our data models for the session.
import '../domain/session_exercise.dart';
import '../domain/logged_set.dart';

// The timer notifier, so we can interact with it.
import 'timer_state.dart';

// The Exercise model from the exercise feature.
import '../../exercises/data/mock_exercise_repository.dart';

// A package for generating unique IDs.
import 'package:uuid/uuid.dart';

// -----------------------------------------------------------------------------
// --- SESSION STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

class SessionStateNotifier extends Notifier<List<SessionExercise>> {
  final _uuid = const Uuid();

  @override
  List<SessionExercise> build() {
    return [];
  }

  /// --- MODIFIED METHOD ---
  /// Adds a new exercise to the current session based on the user's selection.
  /// It now accepts an `Exercise` object as a parameter.
  void addExercise(Exercise exercise) {
    // Create a new SessionExercise using the data from the selected exercise.
    final newExercise = SessionExercise(
      id: _uuid.v4(), // A unique ID for this specific instance in the session
      name: exercise.name,
      target: '3 sets x 10 reps', // Default target for now
      // If this is the first exercise being added, make it the current one.
      isCurrent: state.isEmpty,
    );

    // Add the new exercise to the existing list of exercises in the state.
    state = [...state, newExercise];
  }

  void logSet({required double weight, required int reps}) {
    final currentState = state;
    final currentIndex = currentState.indexWhere((ex) => ex.isCurrent);
    if (currentIndex == -1) return;

    final currentExercise = currentState[currentIndex];

    final newSet = LoggedSet(
      weight: weight,
      reps: reps,
      id: _uuid.v4(),
    );

    final updatedExercise = currentExercise.copyWith(
      loggedSets: [...currentExercise.loggedSets, newSet],
    );

    final newState = List<SessionExercise>.from(currentState);
    newState[currentIndex] = updatedExercise;

    state = newState;

    ref.read(timerStateProvider.notifier).startTimer();
  }

  void selectNextExercise() {
    ref.read(timerStateProvider.notifier).stopTimer();

    final currentState = state;
    final currentIndex = currentState.indexWhere((ex) => ex.isCurrent);

    if (currentIndex != -1 && currentIndex < currentState.length - 1) {
      final newState = [
        for (int i = 0; i < currentState.length; i++)
          if (i == currentIndex)
            currentState[i].copyWith(isCurrent: false)
          else if (i == currentIndex + 1)
            currentState[i].copyWith(isCurrent: true)
          else
            currentState[i]
      ];
      state = newState;
    }
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final sessionStateProvider =
    NotifierProvider<SessionStateNotifier, List<SessionExercise>>(
  SessionStateNotifier.new,
);