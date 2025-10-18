// lib/src/features/workout/presentation/widgets/workout_dock.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/settings/application/settings_provider.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/set_sheet.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/keypad_duration_picker.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT DOCK WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A persistent bottom navigation bar for the in-workout session screen.
class WorkoutDock extends ConsumerWidget {
  const WorkoutDock({super.key});

  /// Shows the new keypad-style picker to set a new duration for a timer preset.
  void _showKeypadPicker(BuildContext context, WidgetRef ref, int timerIndex) async {
    final newDuration = await showModalBottomSheet<Duration>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.colors.surface,
      builder: (context) => const KeypadDurationPicker(),
    );

    if (newDuration != null && newDuration.inSeconds > 0) {
      // Update the preset value in settings.
      await ref.read(settingsProvider.notifier).updateQuickRestTimer(
            index: timerIndex,
            newDuration: newDuration.inSeconds,
          );
      // Immediately start the timer with the new duration.
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- THREE QUICK-SELECT TIMERS ---
            settings.when(
              data: (appSettings) => Row(
                children: List.generate(3, (index) {
                  return _buildQuickTimer(
                    context: context,
                    ref: ref,
                    timerIndex: index,
                    presetDuration: appSettings.quickRestTimers[index],
                    timerState: timerState,
                  );
                }),
              ),
              loading: () => const Row(children: [SizedBox(width: 150)]),
              error: (err, stack) => const Text('Error'),
            ),

            // --- ACTION BUTTON ---
            ElevatedButton.icon(
              onPressed: () async {
                final result = await showModalBottomSheet<Map<String, num>>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppTheme.colors.surface,
                  builder: (context) => const SetSheet(),
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
      ),
    );
  }

  /// A helper widget to build one of the three quick-select timer circles.
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
      onTap: () => ref.read(timerStateProvider.notifier).startTimer(duration: presetDuration),
      onLongPress: () => _showKeypadPicker(context, ref, timerIndex),
      child: Container(
        width: 50,
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