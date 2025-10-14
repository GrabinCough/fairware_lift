// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// Import the session screen to navigate to it.
import 'session_screen.dart';

// -----------------------------------------------------------------------------
// --- START WORKOUT OPTIONS SCREEN WIDGET -------------------------------------
// -----------------------------------------------------------------------------

/// A screen that allows the user to choose how to begin their workout.
///
/// As per SSOT Section 4.4, after the user initiates a workout, they must
/// choose between starting a "Quick Workout" (an empty session) or selecting
/// a pre-defined day from one of their programs.
class StartWorkoutOptionsScreen extends StatelessWidget {
  const StartWorkoutOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SafeArea is essential to avoid the system navigation bar at the bottom.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Start Workout'),
          backgroundColor: AppTheme.colors.surface,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // --- OPTION 1: QUICK WORKOUT ---
                _buildOptionCard(
                  context: context,
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Quick Workout',
                  subtitle: 'Start an empty session',
                  onTap: () {
                    // --- NAVIGATION LOGIC ---
                    // This is the new functionality. When tapped, it will push
                    // the full-screen SessionScreen onto the navigation stack.
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        // We set fullscreenDialog to true to have the new screen
                        // animate up from the bottom, which is a common UX
                        // pattern for entering a distinct "mode" like a workout.
                        fullscreenDialog: true,
                        builder: (context) => const SessionScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // --- OPTION 2: CHOOSE FROM PROGRAM ---
                _buildOptionCard(
                  context: context,
                  icon: Icons.list_alt_rounded,
                  title: 'Choose from Program',
                  subtitle: 'Select a planned day',
                  onTap: () {
                    // TODO: Navigate to the program selection list.
                    print('Choose from Program selected');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Private helper to build a consistent, tappable card for each option.
  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppTheme.colors.surfaceAlt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 48,
                color: AppTheme.colors.accent,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppTheme.typography.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTheme.typography.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}