// ----- lib/src/features/workout/presentation/widgets/workout_dock.dart -----
// lib/src/features/workout/presentation/widgets/workout_dock.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/settings/application/settings_provider.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/keypad_duration_picker.dart';
// --- NEW IMPORTS ---
import 'package:fairware_lift/src/features/exercises/data/presentation/exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/exercises/domain/exercise.dart' as lib_exercise;
import 'package:fairware_lift/src/features/workout/application/session_state.dart';


// -----------------------------------------------------------------------------
// --- WORKOUT DOCK WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A persistent bottom navigation bar for the in-workout session screen.
class WorkoutDock extends ConsumerWidget {
  const WorkoutDock({super.key});

  void _showKeypadPicker(BuildContext context, WidgetRef ref, int timerIndex) async {
    final newDuration = await showModalBottomSheet<Duration>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.colors.surface,
      builder: (context) => const KeypadDurationPicker(),
    );

    if (newDuration != null && newDuration.inSeconds > 0) {
      await ref.read(settingsProvider.notifier).updateQuickRestTimer(
            index: timerIndex,
            newDuration: newDuration.inSeconds,
          );
      ref.read(timerStateProvider.notifier).startTimer(duration: newDuration.inSeconds);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerStateProvider);
    final settings = ref.watch(settingsProvider);

    return BottomAppBar(
      color: AppTheme.colors.background,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        // --- MODIFIED: Layout changed to space between ---
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- MODIFIED: Only one quick-select timer ---
            settings.when(
              data: (appSettings) => _buildQuickTimer(
                context: context,
                ref: ref,
                timerIndex: 0, // Always use the first preset
                presetDuration: appSettings.quickRestTimers.isNotEmpty
                    ? appSettings.quickRestTimers[0]
                    : 60, // Fallback
                timerState: timerState,
              ),
              loading: () => const SizedBox(width: 58, height: 40), // Placeholder
              error: (err, stack) => const Text('Error'),
            ),

            // --- NEW: "Add Exercise" button ---
            TextButton.icon(
              onPressed: () async {
                final result = await Navigator.of(context).push<lib_exercise.Exercise>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const ExercisePickerScreen(),
                  ),
                );
                // Use a mounted check for safety in async gaps
                if (result != null && context.mounted) {
                  ref.read(sessionStateProvider.notifier).addExerciseFromLibrary(result);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Exercise'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTimer({
    required BuildContext context,
    required WidgetRef ref,
    required int timerIndex,
    required int presetDuration,
    required TimerState timerState,
  }) {
    final bool isThisTimerActive =
        timerState.isRunning && timerState.initialDuration == presetDuration;

    final double timerProgress = isThisTimerActive && timerState.initialDuration > 0
        ? timerState.secondsRemaining / timerState.initialDuration
        : 0.0;

    return GestureDetector(
      onTap: () {
        if (isThisTimerActive) {
          ref.read(timerStateProvider.notifier).stopTimer();
        } else {
          ref.read(timerStateProvider.notifier).startTimer(duration: presetDuration);
        }
      },
      onLongPress: () => _showKeypadPicker(context, ref, timerIndex),
      child: Container(
        width: 58, // Increased width for better touch target
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isThisTimerActive)
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
            Text(
              isThisTimerActive
                  ? '${timerState.secondsRemaining}s'
                  : '${presetDuration}s',
              style: AppTheme.typography.body.copyWith(
                fontSize: 14,
                color: isThisTimerActive
                    ? AppTheme.colors.accent
                    : AppTheme.colors.textMuted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}