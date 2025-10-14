// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- SESSION PREVIEW WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// A widget that displays a preview of the user's next planned session.
///
/// As per SSOT Section 5.3, this component gives the user a glimpse of what's
/// next in their program. This is a static placeholder implementation that
/// will be connected to real data later.
class SessionPreview extends StatelessWidget {
  const SessionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    // The main container for the preview section.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- SECTION HEADER ---
        // A descriptive title for this section.
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Next Up: Push Day', // Placeholder title
            style: AppTheme.typography.title,
          ),
        ),

        // --- PREVIEW CARD ---
        // A card that contains the list of exercises.
        Card(
          color: AppTheme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Static placeholder list of exercises.
                // In a real implementation, this would be a dynamically generated list.
                _buildExerciseRow('Barbell Bench Press', '4 sets x 5-8 reps'),
                _buildDivider(),
                _buildExerciseRow('Incline Dumbbell Press', '3 sets x 8-12 reps'),
                _buildDivider(),
                _buildExerciseRow('Overhead Press', '3 sets x 8-12 reps'),
                _buildDivider(),
                _buildExerciseRow('Tricep Pushdown', '3 sets x 10-15 reps'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Private helper to build a consistent row for each exercise.
  Widget _buildExerciseRow(String name, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- LAYOUT FIX ---
          // The exercise name Text widget is wrapped in an Expanded widget.
          // This allows it to fill the available space and prevents the Row
          // from overflowing when the text on the right needs more room.
          Expanded(
            child: Text(
              name,
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.textPrimary,
              ),
              // Handle long exercise names gracefully.
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          // Add a small gap to ensure the text doesn't touch.
          const SizedBox(width: 16),
          // Exercise sets/reps details.
          Text(
            details,
            style: AppTheme.typography.body,
          ),
        ],
      ),
    );
  }

  /// Private helper to build a consistent divider between rows.
  Widget _buildDivider() {
    return Divider(
      color: AppTheme.colors.surfaceAlt,
      height: 1,
      thickness: 1,
    );
  }
}