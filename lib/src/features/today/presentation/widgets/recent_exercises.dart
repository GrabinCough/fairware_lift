// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- RECENT EXERCISES WIDGET -------------------------------------------------
// -----------------------------------------------------------------------------

/// A widget to display a list or carousel of recently performed exercises.
///
/// As per SSOT Section 5.3, this component provides users with a quick look at
/// their recent activity. This static placeholder uses a horizontal ListView
/// to create a scrollable carousel of exercise cards.
class RecentExercises extends StatelessWidget {
  const RecentExercises({super.key});

  @override
  Widget build(BuildContext context) {
    // A Column is used to structure the section with a title and the carousel.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- SECTION HEADER ---
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Recent Exercises',
            style: AppTheme.typography.title,
          ),
        ),

        // --- HORIZONTAL CAROUSEL ---
        // A SizedBox constrains the height of the horizontal ListView.
        SizedBox(
          height: 120, // This height can be adjusted as needed.
          child: ListView(
            // Enables horizontal scrolling.
            scrollDirection: Axis.horizontal,
            // Placeholder data for the carousel items.
            children: const [
              _ExerciseCard(
                name: 'Squat',
                lastSet: '225 lb x 5',
              ),
              _ExerciseCard(
                name: 'Deadlift',
                lastSet: '315 lb x 3',
              ),
              _ExerciseCard(
                name: 'Pull Up',
                lastSet: 'BW x 8',
              ),
              _ExerciseCard(
                name: 'Leg Press',
                lastSet: '450 lb x 10',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// --- PRIVATE EXERCISE CARD WIDGET --------------------------------------------
// -----------------------------------------------------------------------------

/// A private helper widget to define the appearance of a single exercise card
/// within the horizontal carousel.
class _ExerciseCard extends StatelessWidget {
  final String name;
  final String lastSet;

  const _ExerciseCard({
    required this.name,
    required this.lastSet,
  });

  @override
  Widget build(BuildContext context) {
    // A SizedBox defines the width of each card in the carousel.
    return SizedBox(
      width: 150, // This width can be adjusted as needed.
      child: Card(
        color: AppTheme.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exercise Name
              Text(
                name,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                // Handles text that is too long to fit.
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const Spacer(),
              // Last Set Details
              Text(
                'Last Set:',
                style: AppTheme.typography.caption,
              ),
              const SizedBox(height: 4),
              Text(
                lastSet,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}