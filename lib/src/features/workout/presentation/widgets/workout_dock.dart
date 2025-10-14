// lib/src/features/workout/presentation/widgets/workout_dock.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The session state provider and data models.
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/domain/session_exercise.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// The timer state provider.
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';

// The SetSheet UI.
import 'set_sheet.dart';

// --- NEW IMPORT ---
// Import our new custom duration picker.
import 'duration_picker_sheet.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT DOCK WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A persistent bottom navigation bar for the in-workout session screen.
class WorkoutDock extends ConsumerWidget {
  const WorkoutDock({super.key});

  /// A helper to format the seconds into a "90s" format.
  String _formatDuration(int totalSeconds) {
    return '${totalSeconds}s';
  }

  /// --- UPDATED METHOD ---
  /// Shows our new custom bottom sheet for picking a duration.
  void _showTimerPicker(BuildContext context, WidgetRef ref) async {
    // Get the current duration to pre-fill the picker.
    final currentDuration = Duration(
      seconds: ref.read(timerStateProvider).initialDuration,
    );

    // `showModalBottomSheet` now returns the `Duration` selected by the user.
    final selectedDuration = await showModalBottomSheet<Duration>(
      context: context,
      backgroundColor: AppTheme.colors.surface,
      builder: (BuildContext builder) {
        return DurationPickerSheet(initialDuration: currentDuration);
      },
    );

    // If the user selected a duration (didn't just dismiss the sheet),
    // start the timer with that new duration.
    if (selectedDuration != null) {
      ref.read(timerStateProvider.notifier).startTimer(
            duration: selectedDuration.inSeconds,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionExercises = ref.watch(sessionStateProvider);
    final currentExercise = sessionExercises.firstWhere(
      (ex) => ex.isCurrent,
      orElse: () => const SessionExercise(id: '', name: '', target: ''),
    );
    final LoggedSet? lastSet = currentExercise.loggedSets.isNotEmpty
        ? currentExercise.loggedSets.last
        : null;

    final timerState = ref.watch(timerStateProvider);
    final timerNotifier = ref.read(timerStateProvider.notifier);

    // Calculate the progress for the circular indicator.
    final double timerProgress = timerState.isRunning && timerState.initialDuration > 0
        ? timerState.secondsRemaining / timerState.initialDuration
        : 0.0;

    return BottomAppBar(
      color: AppTheme.colors.background,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- TIMER DISPLAY ---
            GestureDetector(
              onTap: () => _showTimerPicker(context, ref),
              child: SizedBox(
                width: 70,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress Indicator
                    if (timerState.isRunning)
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: timerProgress,
                          strokeWidth: 2.0,
                          backgroundColor: AppTheme.colors.surface,
                          color: AppTheme.colors.accent,
                        ),
                      ),
                    // Timer Text
                    Text(
                      timerState.isRunning
                          ? _formatDuration(timerState.secondsRemaining)
                          : 'Rest',
                      style: AppTheme.typography.body.copyWith(
                        fontSize: 14,
                        color: timerState.isRunning
                            ? AppTheme.colors.accent
                            : AppTheme.colors.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- ACTION BUTTONS ---
            Row(
              children: [
                TextButton(
                  onPressed: timerState.isRunning
                      ? () => timerNotifier.addTime(seconds: 30)
                      : null,
                  child: const Text('+30s'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Stop any running timer when moving to the next exercise.
                    timerNotifier.stopTimer();
                    ref.read(sessionStateProvider.notifier).selectNextExercise();
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await showModalBottomSheet<Map<String, num>>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppTheme.colors.surface,
                      builder: (context) => SetSheet(
                        initialWeight: lastSet?.weight,
                        initialReps: lastSet?.reps,
                      ),
                    );

                    if (result != null) {
                      ref.read(sessionStateProvider.notifier).logSet(
                            weight: result['weight']!.toDouble(),
                            reps: result['reps']!.toInt(),
                          );
                    }
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Set'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}