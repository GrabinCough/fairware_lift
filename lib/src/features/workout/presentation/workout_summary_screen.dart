// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The data models for the session.
import '../domain/session_exercise.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT SUMMARY SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

/// A screen that displays a read-only summary of a completed workout session.
///
/// This screen is presented after the user taps "Finish" on the SessionScreen.
/// It shows all the exercises and the sets that were logged for each.
class WorkoutSummaryScreen extends StatelessWidget {
  /// The list of exercises from the completed session.
  final List<SessionExercise> completedExercises;

  const WorkoutSummaryScreen({
    super.key,
    required this.completedExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Workout Summary'),
        actions: [
          // The final action to save the workout to the user's history.
          TextButton(
            onPressed: () {
              // TODO: Implement save logic and navigate back to the root screen.
              print('Save Workout tapped');
            },
            child: Text(
              'Save',
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        // The number of items is the number of exercises in the session.
        itemCount: completedExercises.length,
        itemBuilder: (context, index) {
          final exercise = completedExercises[index];
          // We only show exercises for which at least one set was logged.
          if (exercise.loggedSets.isEmpty) {
            return const SizedBox.shrink(); // Return an empty widget
          }
          return _buildExerciseSummary(exercise);
        },
      ),
    );
  }

  /// A private helper to build the summary card for a single exercise.
  Widget _buildExerciseSummary(SessionExercise exercise) {
    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Name
            Text(
              exercise.name,
              style: AppTheme.typography.title.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 12),
            // Dynamically build a list of the logged sets.
            ...exercise.loggedSets.asMap().entries.map((entry) {
              final setIndex = entry.key + 1;
              final set = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  'Set $setIndex: ${set.weight} lb x ${set.reps} reps',
                  style: AppTheme.typography.body,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}