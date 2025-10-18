// lib/src/features/workout/application/session_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';

// -----------------------------------------------------------------------------
// --- SESSION STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

// --- REFACTOR ---
// The notifier now manages a list of the generic `SessionItem` type.
class SessionStateNotifier extends Notifier<List<SessionItem>> {
  final _uuid = const Uuid();

  @override
  List<SessionItem> build() {
    return [];
  }

  /// Adds a new strength exercise to the current session.
  void addDxgExercise(GeneratedExerciseResult result) {
    final newExercise = SessionItem.exercise(
      id: _uuid.v4(),
      slug: result.slug,
      displayName: result.displayName,
      discriminators: result.discriminators,
      target: '3 sets x 10 reps',
      isCurrent: true,
    );
    final updatedState = [
      for (final item in state)
        if (item is SessionExercise) item.copyWith(isCurrent: false) else item,
      newExercise,
    ];
    state = updatedState;
  }

  /// --- NEW METHOD ---
  /// Adds a new warm-up item to the current session.
  void addWarmupItem(WarmupItem item) {
    final newWarmup = SessionItem.warmup(
      id: _uuid.v4(),
      item: item,
    );
    // When adding a warm-up, we don't change the `isCurrent` status of exercises.
    state = [...state, newWarmup];
  }

  /// Sets the specified exercise as the current one for logging sets.
  void setCurrentItem(String itemId) {
    ref.read(timerStateProvider.notifier).stopTimer();
    final newState = [
      for (final item in state)
        if (item is SessionExercise)
          item.copyWith(isCurrent: item.id == itemId)
        else
          item,
    ];
    state = newState;
  }

  /// Logs a new set for the currently active exercise.
  void logSet({required double weight, required int reps}) {
    final currentState = state;
    final currentIndex = currentState.indexWhere(
        (item) => item is SessionExercise && item.isCurrent);
    if (currentIndex == -1) return;

    final currentExercise = currentState[currentIndex] as SessionExercise;
    final newSet = LoggedSet(
      weight: weight,
      reps: reps,
      id: _uuid.v4(),
    );
    final updatedExercise = currentExercise.copyWith(
      loggedSets: [...currentExercise.loggedSets, newSet],
    );
    final newState = List<SessionItem>.from(currentState);
    newState[currentIndex] = updatedExercise;
    state = newState;

    ref.read(timerStateProvider.notifier).startTimer();
  }

  /// Deletes an item (exercise or warm-up) from the current session.
  void deleteItem(String itemId) {
    final updatedState = state.where((item) => item.id != itemId).toList();
    state = updatedState;
  }

  /// Reorders the items in the current session.
  void reorderItem(int oldIndex, int newIndex) {
    final items = List<SessionItem>.from(state);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final SessionItem item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final sessionStateProvider =
    NotifierProvider<SessionStateNotifier, List<SessionItem>>(
  SessionStateNotifier.new,
);