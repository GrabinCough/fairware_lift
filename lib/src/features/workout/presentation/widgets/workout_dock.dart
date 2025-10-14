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

// The new timer state provider.
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';

// The SetSheet UI.
import 'set_sheet.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT DOCK WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A persistent bottom navigation bar for the in-workout session screen.
///
/// This is a ConsumerWidget, allowing it to interact with Riverpod providers.
class WorkoutDock extends ConsumerWidget {
  const WorkoutDock({super.key});

  /// A helper to format the seconds into a MM:SS format.
  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the session state to get exercise data for the SetSheet.
    final sessionExercises = ref.watch(sessionStateProvider);
    final currentExercise = sessionExercises.firstWhere(
      (ex) => ex.isCurrent,
      orElse: () => const SessionExercise(id: '', name: '', target: ''),
    );
    final LoggedSet? lastSet = currentExercise.loggedSets.isNotEmpty
        ? currentExercise.loggedSets.last
        : null;

    // --- TIMER INTEGRATION ---
    // Watch the new timerStateProvider to get the current timer state.
    // The `WorkoutDock` will now rebuild every time the timer state changes.
    final timerState = ref.watch(timerStateProvider);

    return BottomAppBar(
      color: AppTheme.colors.background,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- TIMER DISPLAY ---
            // The text now dynamically displays the formatted time remaining.
            // It also changes color and text based on whether the timer is running.
            Text(
              timerState.isRunning
                  ? 'Rest: ${_formatDuration(timerState.secondsRemaining)}'
                  : 'Timer',
              style: AppTheme.typography.body.copyWith(
                color: timerState.isRunning
                    ? AppTheme.colors.accent
                    : AppTheme.colors.textMuted,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    print('+30s tapped');
                  },
                  child: const Text('+30s'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    print('Next tapped');
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