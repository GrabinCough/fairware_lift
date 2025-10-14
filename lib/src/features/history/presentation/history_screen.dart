// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- HISTORY SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for displaying a log of all past workouts.
///
/// This implementation shows the "Empty State" UI (SSOT 5.1) which is
/// displayed when the user has not yet logged any workouts.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for the screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      // The body is centered to hold the empty state content.
      body: Center(
        child: Padding(
          // Horizontal padding to keep content from touching screen edges.
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.sizing.baseGrid * 4, // 32pt
          ),
          child: Column(
            // Center the content vertically.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- ILLUSTRATION PLACEHOLDER ---
              // A placeholder for a future illustration. An icon is used for now.
              Icon(
                Icons.bar_chart_rounded,
                size: 80,
                color: AppTheme.colors.textMuted,
              ),
              const SizedBox(height: 24),

              // --- EMPTY STATE MESSAGE ---
              // The message text as specified in SSOT 5.1.
              Text(
                'No workouts logged yet.',
                style: AppTheme.typography.title.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // --- CALL TO ACTION (CTA) BUTTON ---
              // The CTA guides the user to start a workout, which is the action
              // that will eventually populate this screen.
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: This could switch tabs or navigate to the workout flow.
                  print('Start Workout button pressed!');
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start Workout'),
                style: ElevatedButton.styleFrom(
                  // Using the primary style from the theme.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}