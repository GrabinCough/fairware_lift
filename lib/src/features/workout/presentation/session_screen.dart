// lib/src/features/workout/presentation/session_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import '../application/session_state.dart';
import 'widgets/workout_dock.dart';
import 'widgets/exercise_list_item.dart';
import 'workout_summary_screen.dart';

// --- FIX ---
// These imports are now correct, pointing to our new, real files.
import 'package:fairware_lift/src/features/exercises/data/presentation/exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/exercises/domain/exercise.dart';

// -----------------------------------------------------------------------------
// --- SESSION SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// The full-screen UI for an active workout session.
class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  /// --- NEW ---
  /// Shows an AlertDialog with the exercise's "how-to" instructions.
  void _showExerciseInfo(BuildContext context, {required String name, required String howTo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: Text(name),
          content: Text(howTo),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionExercises = ref.watch(sessionStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Quick Workout'),
        actions: [
          TextButton(
            onPressed: () {
              final completedWorkout = ref.read(sessionStateProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkoutSummaryScreen(
                    completedExercises: completedWorkout,
                  ),
                ),
              );
            },
            child: Text(
              'Finish',
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const WorkoutDock(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
        children: [
          if (sessionExercises.isEmpty)
            _buildEmptyState()
          else
            ...sessionExercises.map((exercise) {
              return ExerciseListItem(
                exerciseName: exercise.name,
                target: exercise.target,
                loggedSets: exercise.loggedSets,
                isCurrent: exercise.isCurrent,
                // --- NEW ---
                // Pass the new properties to the list item widget.
                howTo: exercise.howTo,
                onInfoTap: () => _showExerciseInfo(
                  context,
                  name: exercise.name,
                  howTo: exercise.howTo,
                ),
              );
            }),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () async {
              // The navigator now expects our detailed Exercise object.
              final selectedExercise = await Navigator.of(context).push<Exercise>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const ExercisePickerScreen(),
                ),
              );

              if (selectedExercise != null) {
                ref.read(sessionStateProvider.notifier).addExercise(selectedExercise);
              }
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add Exercise'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.colors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0),
        child: Column(
          children: [
            Icon(
              Icons.fitness_center_rounded,
              size: 64,
              color: AppTheme.colors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Your session is empty.',
              style: AppTheme.typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap "Add Exercise" to get started.',
              style: AppTheme.typography.body,
            ),
          ],
        ),
      ),
    );
  }
}