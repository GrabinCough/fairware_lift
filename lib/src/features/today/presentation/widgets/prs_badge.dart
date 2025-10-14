// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- PRs BADGE WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A widget to display recent Personal Records (PRs) on the Today screen.
///
/// As per SSOT Section 5.3, this component serves to motivate the user by
/// highlighting their recent achievements. This is a static placeholder that
/// showcases a few different types of PRs.
class PRsBadge extends StatelessWidget {
  const PRsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // A Column structures the section with a title and the content card.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- SECTION HEADER ---
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Recent PRs',
            style: AppTheme.typography.title,
          ),
        ),

        // --- PRs CARD ---
        Card(
          color: AppTheme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // Placeholder data for recent PRs.
              children: [
                _buildPrRow(
                  icon: Icons.emoji_events_rounded,
                  color: AppTheme.colors.warning,
                  exercise: 'Bench Press',
                  prValue: '185 lb x 8 reps',
                  date: '3 days ago',
                ),
                const SizedBox(height: 16),
                _buildPrRow(
                  icon: Icons.local_fire_department_rounded,
                  color: AppTheme.colors.danger,
                  exercise: 'Squat',
                  prValue: 'Volume: 12,500 lb',
                  date: '5 days ago',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Private helper method to build a consistent row for each PR entry.
  Widget _buildPrRow({
    required IconData icon,
    required Color color,
    required String exercise,
    required String prValue,
    required String date,
  }) {
    return Row(
      children: [
        // --- ICON ---
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 16),

        // --- PR DETAILS ---
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                prValue,
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),

        // --- DATE ---
        Text(
          date,
          style: AppTheme.typography.caption,
        ),
      ],
    );
  }
}