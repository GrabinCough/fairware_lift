// ----- lib/src/features/workout/application/timer_state.dart -----
// lib/src/features/workout/application/timer_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/services/alert_service.dart';
import 'package:fairware_lift/src/features/settings/application/settings_provider.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT METRICS STATE ---------------------------------------------------
// -----------------------------------------------------------------------------

/// A data class to hold live metrics for the current workout session.
@immutable
class WorkoutMetrics {
  final int totalDurationSeconds;
  final int totalRestSeconds;

  const WorkoutMetrics({
    this.totalDurationSeconds = 0,
    this.totalRestSeconds = 0,
  });

  WorkoutMetrics copyWith({
    int? totalDurationSeconds,
    int? totalRestSeconds,
  }) {
    return WorkoutMetrics(
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      totalRestSeconds: totalRestSeconds ?? this.totalRestSeconds,
    );
  }
}

/// A notifier to manage the live workout metrics.
class WorkoutMetricsNotifier extends StateNotifier<WorkoutMetrics> {
  Timer? _stopwatch;

  WorkoutMetricsNotifier() : super(const WorkoutMetrics());

  void startWorkout() {
    state = const WorkoutMetrics(); // Reset on start
    _stopwatch?.cancel();
    _stopwatch = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(totalDurationSeconds: state.totalDurationSeconds + 1);
    });
  }

  void addRestTime(int seconds) {
    state = state.copyWith(totalRestSeconds: state.totalRestSeconds + seconds);
  }

  void stopWorkout() {
    _stopwatch?.cancel();
  }
}

// --- BUG FIX ---
// The `.autoDispose` modifier has been removed from the provider.
// This ensures that the provider's state persists for the entire duration of
// the workout session, even when the UI is rebuilt or navigated away from.
// The state will now only be reset when manually invalidated (e.g., when a
// workout is saved).
final workoutMetricsProvider =
    StateNotifierProvider<WorkoutMetricsNotifier, WorkoutMetrics>(
  (ref) => WorkoutMetricsNotifier(),
);


// -----------------------------------------------------------------------------
// --- CONFIGURABLE VALUES -----------------------------------------------------
// -----------------------------------------------------------------------------

const int kDefaultRestDuration = 90;

// -----------------------------------------------------------------------------
// --- TIMER STATE DATA MODEL --------------------------------------------------
// -----------------------------------------------------------------------------

class TimerState {
  final int secondsRemaining;
  final int initialDuration;
  final bool isRunning;

  const TimerState({
    this.secondsRemaining = 0,
    this.initialDuration = kDefaultRestDuration,
    this.isRunning = false,
  });

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

class TimerStateNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const TimerState();
  }

  void startTimer({int? duration}) {
    _timer?.cancel();

    final settings = ref.read(settingsProvider).value;
    final defaultTimerPreset =
        (settings != null && settings.quickRestTimers.isNotEmpty)
            ? settings.quickRestTimers[0]
            : kDefaultRestDuration;

    final timerDuration = duration ?? defaultTimerPreset;

    state = TimerState(
      secondsRemaining: timerDuration,
      initialDuration: timerDuration,
      isRunning: true,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        if (state.secondsRemaining == 3) {
          ref.read(alertServiceProvider).triggerTimerWarningAlert();
        }
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        ref.read(alertServiceProvider).triggerTimerCompletionAlert();
        stopTimer(isFinished: true);
      }
    });
  }

  void addTime({int seconds = 30}) {
    if (state.isRunning) {
      state = state.copyWith(
        secondsRemaining: state.secondsRemaining + seconds,
      );
    }
  }

  void stopTimer({bool isFinished = false}) {
    if (isFinished) {
      ref.read(workoutMetricsProvider.notifier).addRestTime(state.initialDuration);
    }
    _timer?.cancel();
    state = const TimerState(secondsRemaining: 0, isRunning: false);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final timerStateProvider = NotifierProvider<TimerStateNotifier, TimerState>(
  TimerStateNotifier.new,
);