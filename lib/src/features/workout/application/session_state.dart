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
    final newExercise = SessionExercise(
      id: _uuid.v4(),
      slug: result.slug,
      displayName: result.displayName,
      discriminators: result.discriminators,
      target: '3 sets x 10 reps', // Default target for now
      isCurrent: true,
    );
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

  // --- NEW METHODS FOR EDITING ---

  /// Deletes an exercise from the current session.
  void deleteExercise(String exerciseId) {
    final updatedState =
        state.where((exercise) => exercise.id != exerciseId).toList();
    state = updatedState;
  }

  /// Reorders the exercises in the current session.
  void reorderExercise(int oldIndex, int newIndex) {
    // The list is mutated, so we create a mutable copy first.
    final items = List<SessionExercise>.from(state);
    // Adjust the index if moving an item down the list.
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    // Remove the item from its old position and insert it at the new one.
    final SessionExercise item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    // Update the state with the new, reordered list.
    state = items;
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final sessionStateProvider =
    NotifierProvider<SessionStateNotifier, List<SessionExercise>>(
  SessionStateNotifier.new,
);