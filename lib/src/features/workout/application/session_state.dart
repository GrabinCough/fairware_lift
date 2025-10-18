// lib/src/features/workout/application/session_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout/domain/session_exercise.dart';

// -----------------------------------------------------------------------------
// --- SESSION STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

class SessionStateNotifier extends Notifier<List<SessionExercise>> {
  final _uuid = const Uuid();

  @override
  List<SessionExercise> build() {
    return [];
  }

  /// Adds a new exercise to the current session from the DXG picker.
  void addDxgExercise(GeneratedExerciseResult result) {
    // --- DATA MODEL UPGRADE ---
    // The SessionExercise is now created with the full data from the DXG result.
    final newExercise = SessionExercise(
      id: _uuid.v4(),
      slug: result.slug,
      displayName: result.displayName,
      discriminators: result.discriminators,
      target: '3 sets x 10 reps', // Default target for now
      isCurrent: true,
    );

    // Set all other exercises to not be current before adding the new one.
    final updatedState = [
      for (final ex in state) ex.copyWith(isCurrent: false),
      newExercise,
    ];
    state = updatedState;
  }

  /// Sets the specified exercise as the current one for logging sets.
  void setCurrentExercise(String exerciseId) {
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
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final sessionStateProvider =
    NotifierProvider<SessionStateNotifier, List<SessionExercise>>(
  SessionStateNotifier.new,
);