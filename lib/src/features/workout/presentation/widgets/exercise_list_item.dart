// lib/src/features/workout/presentation/widgets/exercise_list_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE LIST ITEM WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

/// A widget that displays a single exercise within the session's exercise list.
class ExerciseListItem extends StatelessWidget {
  final String exerciseName;
  final String target;
  final bool isCurrent;
  final List<LoggedSet> loggedSets;

  /// --- NEW ---
  /// The "how-to" instructions for the exercise.
  final String howTo;

  /// --- NEW ---
  /// A callback function to be executed when the info button is tapped.
  final VoidCallback onInfoTap;

  const ExerciseListItem({
    super.key,
    required this.exerciseName,
    required this.target,
    required this.loggedSets,
    required this.howTo,
    required this.onInfoTap,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    exerciseName,
                    style: AppTheme.typography.title.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Allow for slightly longer names
                  ),
                ),
                const SizedBox(width: 8),
                // --- NEW ---
                // The target and info button are now grouped in a Row.
                Row(
                  children: [
                    Text(
                      target,
                      style: AppTheme.typography.body,
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.info_outline_rounded),
                      onPressed: onInfoTap,
                      color: AppTheme.colors.textMuted,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(), // Removes extra padding
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- LOGGED SETS ---
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