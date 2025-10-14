// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Our data models for the session.
import '../domain/session_exercise.dart';
import '../domain/logged_set.dart';

// The timer notifier, so we can start it.
import 'timer_state.dart';

// A package for generating unique IDs.
import 'package:uuid/uuid.dart';

// -----------------------------------------------------------------------------
// --- SESSION STATE NOTIFIER --------------------------------------------------
// -----------------------------------------------------------------------------

/// This is the "brain" of our active workout session.
///
/// It holds the list of exercises (`List<SessionExercise>`) and contains all
/// the business logic for modifying that state, such as adding a set.
class SessionStateNotifier extends Notifier<List<SessionExercise>> {
  final _uuid = const Uuid();

  @override
  List<SessionExercise> build() {
    return [
      const SessionExercise(
        id: 'ex1',
        name: 'Barbell Bench Press',
        target: '4 sets x 5-8 reps',
        isCurrent: true,
        loggedSets: [],
      ),
      const SessionExercise(
        id: 'ex2',
        name: 'Incline Dumbbell Press',
        target: '3 sets x 8-12 reps',
        loggedSets: [],
      ),
      const SessionExercise(
        id: 'ex3',
        name: 'Overhead Press',
        target: '3 sets x 8-12 reps',
        loggedSets: [],
      ),
    ];
  }

  /// Logs a new set and starts the rest timer.
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

    // --- TIMER INTEGRATION ---
    // After updating the state, we use `ref.read` to get the TimerStateNotifier
    // and call its `startTimer` method. This fulfills the "Save & Start Rest"
    // promise of the button.
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