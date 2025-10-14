// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The session state provider, so we can invalidate it.
import '../application/session_state.dart';

// Import the session screen to navigate to it.
import 'session_screen.dart';

// -----------------------------------------------------------------------------
// --- START WORKOUT OPTIONS SCREEN WIDGET -------------------------------------
// -----------------------------------------------------------------------------

/// This is now a ConsumerWidget so it can interact with providers.
class StartWorkoutOptionsScreen extends ConsumerWidget {
  const StartWorkoutOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                _buildOptionCard(
                  context: context,
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Quick Workout',
                  subtitle: 'Start an empty session',
                  onTap: () {
                    // --- STATE MANAGEMENT ---
                    // Invalidate the provider to reset the session to a fresh,
                    // empty state before navigating.
                    ref.invalidate(sessionStateProvider);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const SessionScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildOptionCard(
                  context: context,
                  icon: Icons.list_alt_rounded,
                  title: 'Choose from Program',
                  subtitle: 'Select a planned day',
                  onTap: () {
                    // TODO: Implement logic for starting a programmed workout.
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