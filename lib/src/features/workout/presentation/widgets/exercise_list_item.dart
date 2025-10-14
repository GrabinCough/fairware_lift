// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The data model for a logged set.
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE LIST ITEM WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

/// A widget that displays a single exercise within the session's exercise list.
///
/// This widget is responsible for showing the exercise name, its target sets
/// and reps, and visually indicating whether it is the currently active exercise.
class ExerciseListItem extends StatelessWidget {
  final String exerciseName;
  final String target;
  final bool isCurrent;
  // --- STATE INTEGRATION ---
  // It now accepts a list of LoggedSet objects to display.
  final List<LoggedSet> loggedSets;

  const ExerciseListItem({
    super.key,
    required this.exerciseName,
    required this.target,
    required this.loggedSets,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    // A Card provides a clear visual container for the exercise information.
    return Card(
      color: isCurrent ? AppTheme.colors.surfaceAlt : AppTheme.colors.surface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        side: isCurrent
            ? BorderSide(color: AppTheme.colors.accent, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- EXERCISE NAME & TARGET ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exerciseName,
                    style: AppTheme.typography.title.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  target,
                  style: AppTheme.typography.body,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- STATE INTEGRATION ---
            // The hardcoded list has been replaced with a dynamic list builder.
            // It uses the `loggedSets` list passed into the widget to build
            // a _buildSetRow for each set.
            // The `...` is the "spread" operator, which inserts all the
            // generated widgets into this Column.
            ...loggedSets.asMap().entries.map((entry) {
              final index = entry.key;
              final set = entry.value;
              return _buildSetRow(
                setNumber: index + 1,
                details: '${set.weight} lb x ${set.reps} reps',
              );
            }),
          ],
        ),
      ),
    );
  }

  /// A private helper to build a row for a logged set.
  Widget _buildSetRow({required int setNumber, required String details}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Set Number Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.colors.background,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              setNumber.toString(),
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Set Details (Weight x Reps)
          Text(
            details,
            style: AppTheme.typography.body,
          ),
        ],
      ),
    );
  }
}