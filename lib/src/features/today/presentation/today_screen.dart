// lib/src/features/today/presentation/today_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// Import the placeholder widgets for this screen.
import 'widgets/today_header.dart';
import 'widgets/start_continue_cta.dart';
import 'widgets/session_preview.dart';
import 'widgets/recent_exercises.dart';
import 'widgets/prs_badge.dart';

// -----------------------------------------------------------------------------
// --- TODAY SCREEN WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// The primary landing screen for the user, as defined by the SSOT.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure.
    return Scaffold(
      // The AppBar provides a consistent header for the screen.
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: AppTheme.colors.background, // Match scaffold bg
        elevation: 0,
      ),
      // A ListView is used to ensure the content can scroll on smaller devices.
      // --- FIX ---
      // The body is wrapped in a SafeArea. This ensures that even though the
      // AppShell's SafeArea handles the initial layout, this screen's content
      // respects system UI elements if it's ever used outside the shell.
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            AppTheme.sizing.baseGrid * 2, // 16.0 Left
            0,
            AppTheme.sizing.baseGrid * 2, // 16.0 Right
            100.0, // Bottom padding for FAB
          ),
          children: [
            SizedBox(height: AppTheme.sizing.verticalRhythm),
            const TodayHeader(),
            SizedBox(height: AppTheme.sizing.verticalRhythm),
            const StartContinueCTA(),
            SizedBox(height: AppTheme.sizing.verticalRhythm),
            const SessionPreview(),
            SizedBox(height: AppTheme.sizing.verticalRhythm),
            const RecentExercises(),
            SizedBox(height: AppTheme.sizing.verticalRhythm),
            const PRsBadge(),
          ],
        ),
      ),
    );
  }
}