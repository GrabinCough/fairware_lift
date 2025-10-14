// lib/src/features/workout/application/timer_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Dart's async library, which contains the Timer class.
import 'dart:async';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- FINAL FIX ---
// Reverting to the standard, correct package-style imports.
import 'package:fairware_lift/src/core/services/alert_service.dart';
import 'package:fairware_lift/src/features/settings/application/settings_provider.dart';

// -----------------------------------------------------------------------------
// --- CONFIGURABLE VALUES -----------------------------------------------------
// -----------------------------------------------------------------------------

/// The fallback rest duration in seconds if no user preference is set.
const int kDefaultRestDuration = 90;

// -----------------------------------------------------------------------------
// --- TIMER STATE DATA MODEL --------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple class to hold the state of the rest timer.
class TimerState {
  /// The number of seconds remaining on the timer.
  final int secondsRemaining;

  /// The initial duration the timer was set for. This is used for UI progress indicators.
  final int initialDuration;

  /// A flag indicating whether the timer is currently running.
  final bool isRunning;

  const TimerState({
    this.secondsRemaining = 0,
    this.initialDuration = kDefaultRestDuration,
    this.isRunning = false,
  });

  /// Creates a copy of the state with some values replaced.
  TimerState copyWith({
    int? secondsRemaining,
    int? initialDuration,
    bool? isRunning,
  }) {
    return TimerState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      initialDuration: initialDuration ?? this.initialDuration,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}

// -----------------------------------------------------------------------------
// --- TIMER STATE NOTIFIER ----------------------------------------------------
// -----------------------------------------------------------------------------

/// This is the "brain" for the rest timer.
/// It manages the countdown, state changes, and completion alerts.
class TimerStateNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    // Ensure the timer is cancelled when the provider is disposed.
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const TimerState();
  }

  /// Starts the rest timer.
  ///
  /// If a [duration] is provided, it will be used. Otherwise, it will attempt
  /// to fetch the user's preferred rest duration from the settings provider.
  /// If that is not available, it falls back to the `kDefaultRestDuration`.
  void startTimer({int? duration}) {
    _timer?.cancel(); // Cancel any existing timer.

    // Determine the duration for this rest period.
    // Note: We use .value to access the data from the AsyncValue provided by settingsProvider.
    final userPreferredDuration = ref.read(settingsProvider).value?.defaultRestDuration;
    final timerDuration = duration ?? userPreferredDuration ?? kDefaultRestDuration;

    // Set the initial state for the new timer.
    state = TimerState(
      secondsRemaining: timerDuration,
      initialDuration: timerDuration,
      isRunning: true,
    );

    // Start the periodic timer to tick down every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        // If time is left, decrement the remaining seconds.
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        // --- ALERT LOGIC ---
        // When the timer hits zero, stop it and trigger the completion alert.
        ref.read(alertServiceProvider).triggerTimerCompletionAlert();
        stopTimer(isFinished: true);
      }
    });
  }

  /// Adds a specified number of seconds to the current timer.
  void addTime({int seconds = 30}) {
    if (state.isRunning) {
      state = state.copyWith(
        secondsRemaining: state.secondsRemaining + seconds,
      );
    }
  }

  /// Stops the timer and resets its state.
  ///
  /// The [isFinished] flag is used to differentiate between a user-cancelled
  /// timer and one that completed its countdown. We can use this later to
  /// control haptics or other feedback.
  void stopTimer({bool isFinished = false}) {
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