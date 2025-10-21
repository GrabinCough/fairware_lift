// lib/src/features/workout/application/session_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:fairware_lift/src/features/exercises/domain/exercise.dart' as lib_exercise;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';

// -----------------------------------------------------------------------------
// --- SESSION STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

class SessionStateNotifier extends Notifier<List<SessionItem>> {
  final _uuid = const Uuid();

  @override
  List<SessionItem> build() {
    return [];
  }

  void importWorkout(List<SessionItem> importedItems) {
    if (importedItems.isNotEmpty) {
      final firstItem = importedItems.first;
      if (firstItem is SessionExercise) {
        importedItems[0] = firstItem.copyWith(isCurrent: true);
      } else if (firstItem is SessionSuperset && firstItem.exercises.isNotEmpty) {
        final firstExerciseInSuperset = firstItem.exercises.first.copyWith(isCurrent: true);
        final updatedExercises = [firstExerciseInSuperset, ...firstItem.exercises.skip(1)];
        importedItems[0] = firstItem.copyWith(exercises: updatedExercises);
      }
    }
    state = importedItems;
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

  void addExerciseFromLibrary(lib_exercise.Exercise exercise) {
    final newExercise = SessionItem.exercise(
      id: _uuid.v4(),
      slug: exercise.name.toLowerCase().replaceAll(' ', '-'),
      exerciseHash: 'library_${exercise.name}',
      displayName: exercise.name,
      // --- FIX ---
      // The defaultSetType from the library exercise is now passed through.
      defaultSetType: exercise.defaultSetType,
      prescription: const Prescription(
        sets: 3,
        reps: '8-12',
        restSeconds: 90,
        restSecondsAfter: 0,
      ),
      variation: {
        'equipment': exercise.equipment,
        'pattern': exercise.movementPattern,
      },
      info: Info(howTo: exercise.howTo),
      unmapped: false,
    );

    state = [...state, newExercise];
  }

  void addWarmupItem(WarmupItem item, Map<String, String> selectedParameters) {
    final newWarmup = SessionItem.warmup(
      id: _uuid.v4(),
      item: item,
      selectedParameters: selectedParameters,
    );

    final timeParam = selectedParameters['Time (minutes)'];
    if (timeParam != null) {
      final minutes = int.tryParse(timeParam) ?? 0;
      if (minutes > 0) {
        ref.read(workoutMetricsProvider.notifier).addActivityTime(seconds: minutes * 60);
      }
    }

    state = [...state, newWarmup];
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

  void logSet(LoggedSet set) {
    SessionSuperset? parentSuperset;
    SessionExercise? currentExercise;
    int currentExerciseIndex = -1;

    for (final item in state) {
      if (item is SessionExercise && item.isCurrent) {
        currentExercise = item;
        break;
      }
      if (item is SessionSuperset) {
        final index = item.exercises.indexWhere((e) => e.isCurrent);
        if (index != -1) {
          parentSuperset = item;
          currentExercise = item.exercises[index];
          currentExerciseIndex = index;
          break;
        }
      }
    }

    if (currentExercise == null) return;

    final updatedExercise = currentExercise.copyWith(loggedSets: [...currentExercise.loggedSets, set]);

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
    
    if (set.setType == 'timed' && set.durationSeconds != null) {
      ref.read(workoutMetricsProvider.notifier).addActivityTime(seconds: set.durationSeconds!);
    }

    int? restDuration;
    if (parentSuperset == null) {
      restDuration = currentExercise.prescription.restSeconds;
    } else {
      restDuration = currentExercise.prescription.restSecondsAfter;
      if (currentExerciseIndex == parentSuperset.exercises.length - 1) {
         restDuration = currentExercise.prescription.restSecondsAfter;
      }
    }

    ref.read(timerStateProvider.notifier).startTimer(duration: restDuration);
  }

  void logWeightReps({required double weight, required int reps, double? rpe}) {
    final id = _uuid.v4();
    logSet(LoggedSet.weightReps(id: id, weight: weight, reps: reps, rpe: rpe));
  }

  void logTimed({required int durationSeconds, Map<String, dynamic> metrics = const {}}) {
    final id = _uuid.v4();
    logSet(LoggedSet.timed(id: id, durationSeconds: durationSeconds, metrics: metrics));
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
          exercises: item.exercises.where((e) => e.id != exerciseId).toList(),
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