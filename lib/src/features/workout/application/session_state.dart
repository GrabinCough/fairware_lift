// ----- lib/src/features/workout/application/session_state.dart -----
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

class SessionStateNotifier extends Notifier<List<SessionItem>> {
  final _uuid = const Uuid();

  @override
  List<SessionItem> build() {
    return [];
  }

  /// --- NEW ---
  /// Sets all exercises (standalone or in supersets) to not be the current one.
  List<SessionItem> _deactivateAllExercises(List<SessionItem> currentState) {
    return currentState.map((item) {
      return switch (item) {
        SessionExercise e => e.copyWith(isCurrent: false),
        SessionSuperset s => s.copyWith(
            exercises: s.exercises
                .map((e) => e.copyWith(isCurrent: false))
                .toList()),
        _ => item,
      };
    }).toList();
  }

  /// Adds a new standalone strength exercise to the current session.
  void addDxgExercise(GeneratedExerciseResult result) {
    final newExercise = SessionItem.exercise(
      id: _uuid.v4(),
      slug: result.slug,
      displayName: result.displayName,
      discriminators: result.discriminators,
      target: '3 sets x 10 reps',
      isCurrent: true,
    );
    final deactivatedState = _deactivateAllExercises(state);
    state = [...deactivatedState, newExercise];
  }

  /// Adds a new warm-up item to the current session.
  void addWarmupItem(WarmupItem item, Map<String, String> selectedParameters) {
    final newWarmup = SessionItem.warmup(
      id: _uuid.v4(),
      item: item,
      selectedParameters: selectedParameters,
    );
    state = [...state, newWarmup];
  }

  /// --- NEW ---
  /// Adds an empty superset block to the session.
  void addSuperset() {
    final newSuperset = SessionItem.superset(id: _uuid.v4());
    state = [...state, newSuperset];
  }

  /// --- NEW ---
  /// Adds a selected exercise to a specific superset block.
  void addExerciseToSuperset({
    required String supersetId,
    required GeneratedExerciseResult result,
  }) {
    final newExercise = SessionExercise(
      id: _uuid.v4(),
      slug: result.slug,
      displayName: result.displayName,
      discriminators: result.discriminators,
      target: '3 sets x 10 reps',
      isCurrent: true,
    );

    final deactivatedState = _deactivateAllExercises(state);

    state = deactivatedState.map((item) {
      if (item is SessionSuperset && item.id == supersetId) {
        return item.copyWith(
          exercises: [...item.exercises, newExercise],
        );
      }
      return item;
    }).toList();
  }

  /// Sets the specified exercise as the current one for logging sets.
  /// Can handle exercises that are standalone or inside a superset.
  void setCurrentItem({required String itemId}) {
    final newState = _deactivateAllExercises(state);

    state = newState.map((item) {
      return switch (item) {
        SessionExercise e when e.id == itemId => e.copyWith(isCurrent: true),
        SessionSuperset s => s.copyWith(
            exercises: s.exercises.map((e) {
            return e.id == itemId ? e.copyWith(isCurrent: true) : e;
          }).toList()),
        _ => item,
      };
    }).toList();
  }

  /// Logs a new set for the currently active exercise.
  /// Contains special logic to only start the timer after the last exercise in a superset.
  void logSet({required double weight, required int reps}) {
    SessionSuperset? parentSuperset;
    SessionExercise? currentExercise;
    int currentExerciseIndex = -1;

    // Find the current exercise and its parent superset, if any.
    for (final item in state) {
      if (item is SessionExercise && item.isCurrent) {
        currentExercise = item;
        break;
      }
      if (item is SessionSuperset) {
        final index =
            item.exercises.indexWhere((e) => e.isCurrent);
        if (index != -1) {
          parentSuperset = item;
          currentExercise = item.exercises[index];
          currentExerciseIndex = index;
          break;
        }
      }
    }

    if (currentExercise == null) return;

    final newSet = LoggedSet(weight: weight, reps: reps, id: _uuid.v4());
    final updatedExercise =
        currentExercise.copyWith(loggedSets: [...currentExercise.loggedSets, newSet]);

    // Update the state with the new set.
    state = state.map((item) {
      if (item.id == currentExercise!.id) return updatedExercise;
      if (item.id == parentSuperset?.id) {
        return (item as SessionSuperset).copyWith(
          exercises: item.exercises
              .map((e) => e.id == updatedExercise.id ? updatedExercise : e)
              .toList(),
        );
      }
      return item;
    }).toList();

    // Timer logic: only start if it's a standalone exercise or the last in a superset.
    if (parentSuperset == null ||
        currentExerciseIndex == parentSuperset.exercises.length - 1) {
      ref.read(timerStateProvider.notifier).startTimer();
    }
  }

  /// Deletes a top-level item (exercise, warm-up, or entire superset) from the session.
  void deleteItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  /// --- NEW ---
  /// Deletes a single exercise from within a superset block.
  void deleteExerciseFromSuperset({
    required String supersetId,
    required String exerciseId,
  }) {
    state = state.map((item) {
      if (item is SessionSuperset && item.id == supersetId) {
        return item.copyWith(
          exercises:
              item.exercises.where((e) => e.id != exerciseId).toList(),
        );
      }
      return item;
    }).toList();
  }

  /// Reorders top-level items in the current session.
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