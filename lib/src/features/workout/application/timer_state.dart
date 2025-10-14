// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Dart's async library, which contains the Timer class.
import 'dart:async';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------------------------
// --- TIMER STATE DATA MODEL --------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple class to hold the state of the rest timer.
class TimerState {
  /// The number of seconds remaining on the timer.
  final int secondsRemaining;

  /// A flag indicating whether the timer is currently running.
  final bool isRunning;

  const TimerState({this.secondsRemaining = 0, this.isRunning = false});
}

// -----------------------------------------------------------------------------
// --- TIMER STATE NOTIFIER ----------------------------------------------------
// -----------------------------------------------------------------------------

/// This is the "brain" for the rest timer.
class TimerStateNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const TimerState();
  }

  /// Starts the rest timer with a given duration.
  void startTimer({int duration = 90}) {
    _timer?.cancel();
    state = TimerState(secondsRemaining: duration, isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = TimerState(
          secondsRemaining: state.secondsRemaining - 1,
          isRunning: true,
        );
      } else {
        stopTimer();
      }
    });
  }

  /// Adds a specified number of seconds to the current timer.
  void addTime({int seconds = 30}) {
    if (state.isRunning) {
      state = TimerState(
        secondsRemaining: state.secondsRemaining + seconds,
        isRunning: true,
      );
    }
  }

  /// Stops the timer and resets its state.
  void stopTimer() {
    _timer?.cancel();
    state = const TimerState(secondsRemaining: 0, isRunning: false);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// The global provider that allows the UI to access the TimerStateNotifier.
final timerStateProvider = NotifierProvider<TimerStateNotifier, TimerState>(
  TimerStateNotifier.new,
);