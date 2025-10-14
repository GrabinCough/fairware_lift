// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The session state provider (our app's "brain").
import '../application/session_state.dart';

// The widgets for this screen.
import 'widgets/workout_dock.dart';
import 'widgets/exercise_list_item.dart';

// The summary screen to navigate to.
import 'workout_summary_screen.dart';

// --- THIS IS THE CORRECTED IMPORT ---
// The import path now correctly points to data/presentation.
import 'package:fairware_lift/src/features/exercises/data/presentation/exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/exercises/data/mock_exercise_repository.dart';

// -----------------------------------------------------------------------------
// --- SESSION SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// The full-screen UI for an active workout session.
class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

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
            _buildEmptyState(ref)
          else
            ...sessionExercises.map((exercise) {
              return ExerciseListItem(
                exerciseName: exercise.name,
                target: exercise.target,
                loggedSets: exercise.loggedSets,
                isCurrent: exercise.isCurrent,
              );
            }),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () async {
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

  Widget _buildEmptyState(WidgetRef ref) {
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