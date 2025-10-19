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

  void addWarmupItem(WarmupItem item, Map<String, String> selectedParameters) {
    final newWarmup = SessionItem.warmup(
      id: _uuid.v4(),
      item: item,
      selectedParameters: selectedParameters,
    );

    // If the warmup has a time parameter, add its duration to the workout metrics.
    final timeParam = selectedParameters['Time (minutes)'];
    if (timeParam != null) {
      final minutes = int.tryParse(timeParam) ?? 0;
      if (minutes > 0) {
        ref.read(workoutMetricsProvider.notifier).addActivityTime(seconds: minutes * 60);
      }
    }

    state = [...state, newWarmup];
  }

  void addSuperset() {
    final newSuperset = SessionItem.superset(id: _uuid.v4());
    state = [...state, newSuperset];
  }

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

  void logSet({required double weight, required int reps}) {
    SessionSuperset? parentSuperset;
    SessionExercise? currentExercise;
    int currentExerciseIndex = -1;

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

    if (parentSuperset == null ||
        currentExerciseIndex == parentSuperset.exercises.length - 1) {
      ref.read(timerStateProvider.notifier).startTimer();
    }
  }

  void deleteItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

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