// lib/src/features/workout/presentation/start_workout_options_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/presentation/session_screen.dart';
import 'package:fairware_lift/src/features/workout_import/presentation/paste_workout_screen.dart';

// -----------------------------------------------------------------------------
// --- START WORKOUT OPTIONS SCREEN WIDGET -------------------------------------
// -----------------------------------------------------------------------------

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
                const SizedBox(height: 16),
                _buildOptionCard(
                  context: context,
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Quick Workout',
                  subtitle: 'Start an empty session',
                  onTap: () {
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
                  icon: Icons.paste_rounded,
                  title: 'Import from Text',
                  subtitle: 'Paste a workout from an LLM',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const PasteWorkoutScreen(),
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