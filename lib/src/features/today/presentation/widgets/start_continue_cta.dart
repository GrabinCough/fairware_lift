// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- START/CONTINUE CTA WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

/// A widget for the primary "Start/Continue" call-to-action on the Today screen.
///
/// As per SSOT Section 5.3, this is the main entry point for a user's workout.
/// It's designed as a large, easily tappable card that clearly communicates
/// the next action. For now, it is a static placeholder.
class StartContinueCTA extends StatelessWidget {
  const StartContinueCTA({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a GestureDetector to make the entire card tappable.
    return GestureDetector(
      onTap: () {
        // TODO: Implement the action to start a new workout.
        print('Start/Continue CTA tapped!');
      },
      child: Card(
        // Using the surface color from our theme for the card background.
        color: AppTheme.colors.surface,
        // Applying the standard card radius from our theme.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        ),
        // No elevation is needed as per the dark theme design.
        elevation: 0,
        child: Padding(
          // Using generous padding for a clean, spacious look.
          // The vertical rhythm constant ensures consistent vertical spacing.
          padding: EdgeInsets.all(AppTheme.sizing.verticalRhythm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- TEXT CONTENT ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Workout', // Placeholder text
                    style: AppTheme.typography.title.copyWith(
                      color: AppTheme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Begin a new session', // Placeholder subtitle
                    style: AppTheme.typography.body,
                  ),
                ],
              ),

              // --- ICON ---
              // The icon acts as a visual affordance for the action.
              Icon(
                Icons.play_circle_fill_rounded,
                color: AppTheme.colors.accent,
                size: AppTheme.sizing.touchTargetMinimum, // Ensures a large tap target
              ),
            ],
          ),
        ),
      ),
    );
  }
}