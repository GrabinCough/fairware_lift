// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- TODAY HEADER WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A widget to display the header information on the "Today" screen.
///
/// As per SSOT Section 5.3, this component is responsible for showing the
/// current date, the user's last recorded bodyweight, and their fasted/fed
/// status. This widget uses placeholder data for now.
class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // A Row is used to lay out the header elements horizontally.
    return Row(
      // `spaceBetween` alignment pushes the date to the left and the other
      // elements to the right, creating a clean, balanced layout.
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center, // Vertically align items
      children: [
        // --- LAYOUT FIX ---
        // The date display Column is wrapped in an Expanded widget. This tells
        // the Column to fill all available horizontal space, which pushes the
        // metrics Row to the right edge and gives it the room it needs,
        // preventing an overflow.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TUESDAY', // Placeholder
                style: AppTheme.typography.caption.copyWith(
                  color: AppTheme.colors.textMuted,
                ),
              ),
              Text(
                'October 14, 2025', // Placeholder
                style: AppTheme.typography.title,
                // Prevent text from wrapping if space is tight.
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Add a small gap between the date and the metrics.
        const SizedBox(width: 16),

        // --- BODYWEIGHT & FASTED STATUS ---
        // This Row will now have enough space because the date Column is flexible.
        Row(
          mainAxisSize: MainAxisSize.min, // Take up only needed space
          children: [
            _buildMetric(
              icon: Icons.monitor_weight_outlined,
              value: '185.2', // Placeholder
              unit: 'lb',
            ),
            const SizedBox(width: 16),
            _buildMetric(
              icon: Icons.wb_sunny_outlined,
              value: 'Fasted', // Placeholder
              unit: '',
            ),
          ],
        ),
      ],
    );
  }

  /// A private helper method to build a consistent metric display.
  ///
  /// This encapsulates the common styling for icon-value-unit combinations,
  /// promoting code reuse and easier maintenance.
  Widget _buildMetric({
    required IconData icon,
    required String value,
    required String unit,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.colors.textMuted,
          size: 20,
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: AppTheme.typography.body,
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  color: AppTheme.colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (unit.isNotEmpty)
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    color: AppTheme.colors.textMuted,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}