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
///
/// It holds the timer's state (seconds remaining, running status) and contains
/// the logic for starting, ticking, and stopping the timer.
class TimerStateNotifier extends Notifier<TimerState> {
  // A private variable to hold the actual Dart Timer object.
  Timer? _timer;

  @override
  TimerState build() {
    // The initial state of the timer is 0 seconds and not running.
    // --- FIX FOR DISPOSE ERROR ---
    // Riverpod's `ref.onDispose` is the correct way to handle cleanup.
    // This ensures the timer is cancelled if the provider is ever disposed.
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const TimerState();
  }

  /// Starts the rest timer with a given duration.
  void startTimer({int duration = 90}) {
    // If a timer is already running, cancel it before starting a new one.
    _timer?.cancel();

    // Set the initial state when the timer starts.
    state = TimerState(secondsRemaining: duration, isRunning: true);

    // Create a periodic timer that fires every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        // If there's time left, decrement the seconds.
        state = TimerState(
          secondsRemaining: state.secondsRemaining - 1,
          isRunning: true,
        );
      } else {
        // If the timer reaches 0, stop it.
        stopTimer();
      }
    });
  }

  /// Stops the timer and resets its state.
  void stopTimer() {
    _timer?.cancel();
    state = const TimerState(secondsRemaining: 0, isRunning: false);
  }

  // --- FIX FOR DISPOSE ERROR ---
  // The incorrect `dispose` method has been removed. Cleanup is now handled
  // correctly in the `build` method with `ref.onDispose`.
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// The global provider that allows the UI to access the TimerStateNotifier.
final timerStateProvider = NotifierProvider<TimerStateNotifier, TimerState>(
  TimerStateNotifier.new,
);