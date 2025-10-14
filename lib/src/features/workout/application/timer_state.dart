// lib/src/features/workout/application/timer_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Dart's async library, which contains the Timer class.
import 'dart:async';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The service responsible for playing sounds and vibrating the device.
import 'package:fairware_lift/src/core/services/alert_service.dart';

// The provider that manages the user's default settings.
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
  /// If a [duration] is provided, it will be used. Otherwise, it will default
  /// to the first quick-select timer preset.
  void startTimer({int? duration}) {
    _timer?.cancel(); // Cancel any existing timer.

    // --- FIX ---
    // Instead of looking for the old 'defaultRestDuration', we now read the list
    // of 'quickRestTimers' and default to the first one if it exists.
    final settings = ref.read(settingsProvider).value;
    final defaultTimerPreset =
        (settings != null && settings.quickRestTimers.isNotEmpty)
            ? settings.quickRestTimers[0]
            : kDefaultRestDuration;

    final timerDuration = duration ?? defaultTimerPreset;

    // Set the initial state for the new timer.
    state = TimerState(
      secondsRemaining: timerDuration,
      initialDuration: timerDuration,
      isRunning: true,
    );

    // Start the periodic timer to tick down every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        // The warning alert now triggers at exactly 3 seconds.
        if (state.secondsRemaining == 3) {
          ref.read(alertServiceProvider).triggerTimerWarningAlert();
        }

        // Decrement the remaining seconds.
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
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