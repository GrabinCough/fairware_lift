// lib/src/features/workout/application/session_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/session_exercise.dart';
import '../domain/logged_set.dart';
import 'timer_state.dart';
import '../../exercises/domain/exercise.dart';
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

  /// Adds a new exercise to the current session.
  void addExercise(Exercise exercise) {
    final newExercise = SessionExercise(
      id: _uuid.v4(),
      name: exercise.name,
      target: '3 sets x 10 reps',
      howTo: exercise.howTo,
      // If this is the first exercise, make it current. Otherwise, don't.
      isCurrent: state.isEmpty,
    );

    // Set all other exercises to not be current before adding the new one.
    final updatedState = [
      for (final ex in state) ex.copyWith(isCurrent: false),
      newExercise.copyWith(isCurrent: true) // Make the new one current
    ];
    state = updatedState;
  }

  /// --- NEW METHOD ---
  /// Sets the specified exercise as the current one for logging sets.
  void setCurrentExercise(String exerciseId) {
    // Stop any running timer when switching exercises.
    ref.read(timerStateProvider.notifier).stopTimer();

    final newState = [
      for (final exercise in state)
        exercise.copyWith(isCurrent: exercise.id == exerciseId)
    ];
    state = newState;
  }

  /// Logs a new set for the currently active exercise.
  void logSet({required double weight, required int reps}) {
    final currentState = state;
    final currentIndex = currentState.indexWhere((ex) => ex.isCurrent);
    if (currentIndex == -1) return; // No active exercise.

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

    // Auto-start the rest timer.
    ref.read(timerStateProvider.notifier).startTimer();
  }

  // The old `selectNextExercise` method has been removed.
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final sessionStateProvider =
    NotifierProvider<SessionStateNotifier, List<SessionExercise>>(
  SessionStateNotifier.new,
);