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
  /// Wall-clock time from start to finish.
  final int totalDurationSeconds;
  /// Sum of all timed warm-ups and completed rest periods.
  final int totalActivitySeconds;
  /// Sum of all completed rest periods.
  final int totalRestSeconds;

  const WorkoutMetrics({
    this.totalDurationSeconds = 0,
    this.totalActivitySeconds = 0,
    this.totalRestSeconds = 0,
  });

  WorkoutMetrics copyWith({
    int? totalDurationSeconds,
    int? totalActivitySeconds,
    int? totalRestSeconds,
  }) {
    return WorkoutMetrics(
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      totalActivitySeconds: totalActivitySeconds ?? this.totalActivitySeconds,
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

  void addActivityTime({required int seconds, bool isRest = false}) {
    state = state.copyWith(
      totalActivitySeconds: state.totalActivitySeconds + seconds,
      totalRestSeconds: isRest ? state.totalRestSeconds + seconds : state.totalRestSeconds,
    );
  }

  void stopWorkout() {
    _stopwatch?.cancel();
  }
}

final workoutMetricsProvider =
    StateNotifierProvider<WorkoutMetricsNotifier, WorkoutMetrics>(
  (ref) => WorkoutMetricsNotifier(),
);


// -----------------------------------------------------------------------------
// --- CONFIGURABLE VALUES -----------------------------------------------------
// -----------------------------------------------------------------------------

const int kDefaultRestDuration = 90;

// -----------------------------------------------------------------------------
// --- TIMER STATE DATA MODEL (MODIFIED) ---------------------------------------
// -----------------------------------------------------------------------------

/// Represents the state of the workout timer.
/// This class is now aligned with the SSOT for watch communication.
class TimerState {
  /// The remaining seconds on the timer.
  final int seconds;
  final bool isRunning;
  /// The timestamp of the last state change, used to resolve stale data on the watch.
  final int epochMillis;
  // This is kept locally on the phone for progress bar calculations.
  final int initialDuration;

  const TimerState({
    required this.seconds,
    required this.isRunning,
    required this.epochMillis,
    this.initialDuration = kDefaultRestDuration,
  });

  /// Creates a serializable map for sending to the watch.
  Map<String, dynamic> toMap() => {
    "seconds": seconds,
    "isRunning": isRunning,
    "ts": epochMillis,
    "v": 1, // Payload versioning
  };

  TimerState copyWith({
    int? seconds,
    bool? isRunning,
    int? epochMillis,
    int? initialDuration,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
      epochMillis: epochMillis ?? this.epochMillis,
      initialDuration: initialDuration ?? this.initialDuration,
    );
  }
}

// -----------------------------------------------------------------------------
// --- TIMER STATE NOTIFIER (MODIFIED) -----------------------------------------
// -----------------------------------------------------------------------------

class TimerStateNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    // The initial state now requires all fields.
    return TimerState(
      seconds: 0,
      isRunning: false,
      epochMillis: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Starts the rest timer for a given duration.
  void startTimer({int? duration}) {
    _timer?.cancel();

    final settings = ref.read(settingsProvider).value;
    final defaultTimerPreset =
        (settings != null && settings.quickRestTimers.isNotEmpty)
            ? settings.quickRestTimers[0]
            : kDefaultRestDuration;

    final timerDuration = duration ?? defaultTimerPreset;

    state = TimerState(
      seconds: timerDuration,
      initialDuration: timerDuration,
      isRunning: true,
      epochMillis: DateTime.now().millisecondsSinceEpoch,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.seconds > 0) {
        if (state.seconds == 3) {
          ref.read(alertServiceProvider).triggerTimerWarningAlert();
        }
        // Every tick is a state change, so we update the timestamp.
        state = state.copyWith(
          seconds: state.seconds - 1,
          epochMillis: DateTime.now().millisecondsSinceEpoch,
        );
      } else {
        ref.read(alertServiceProvider).triggerTimerCompletionAlert();
        stopTimer(isFinished: true);
      }
    });
  }

  /// Adds a specified number of seconds to the running timer.
  void addTime({int seconds = 30}) {
    if (state.isRunning) {
      state = state.copyWith(
        seconds: state.seconds + seconds,
        epochMillis: DateTime.now().millisecondsSinceEpoch,
      );
    }
  }

  /// Stops the timer, optionally marking it as a completed rest period.
  void stopTimer({bool isFinished = false}) {
    if (isFinished) {
      ref.read(workoutMetricsProvider.notifier).addActivityTime(seconds: state.initialDuration, isRest: true);
    }
    _timer?.cancel();
    state = TimerState(
      seconds: 0,
      isRunning: false,
      epochMillis: DateTime.now().millisecondsSinceEpoch,
      initialDuration: state.initialDuration,
    );
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final timerStateProvider = NotifierProvider<TimerStateNotifier, TimerState>(
  TimerStateNotifier.new,
);