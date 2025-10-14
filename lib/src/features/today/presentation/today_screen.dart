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
///
/// This screen provides an overview of the user's current status and serves as
/// the main entry point for starting or continuing a workout session. It is
/// composed of several modular widgets, each representing a distinct section
/// of the UI as specified in SSOT Section 5.3.
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
      body: ListView(
        // --- LAYOUT FIX ---
        // Added padding to all sides. The bottom padding is crucial to prevent
        // the FloatingActionButton from obscuring the last items in the list.
        // A value of 100.0 provides ample space.
        padding: EdgeInsets.fromLTRB(
          AppTheme.sizing.baseGrid * 2, // 16.0 Left
          0, // Top padding is handled by the SizedBox below
          AppTheme.sizing.baseGrid * 2, // 16.0 Right
          100.0, // Bottom
        ),
        children: [
          // The vertical rhythm from the SSOT (24px) is used for spacing
          // between major sections to ensure visual consistency.
          SizedBox(height: AppTheme.sizing.verticalRhythm),

          // --- HEADER ---
          // Displays date, bodyweight, and fasted/fed status.
          const TodayHeader(),
          SizedBox(height: AppTheme.sizing.verticalRhythm),

          // --- START/CONTINUE CTA ---
          // The primary call-to-action to begin a new workout.
          const StartContinueCTA(),
          SizedBox(height: AppTheme.sizing.verticalRhythm),

          // --- SESSION PREVIEW ---
          // Shows a preview of the next planned workout session.
          const SessionPreview(),
          SizedBox(height: AppTheme.sizing.verticalRhythm),

          // --- RECENT EXERCISES ---
          // A carousel or list of recently performed exercises.
          const RecentExercises(),
          SizedBox(height: AppTheme.sizing.verticalRhythm),

          // --- PRs BADGE ---
          // A badge or card highlighting recent personal records.
          const PRsBadge(),

          // Note: An explicit SizedBox is no longer needed at the end because
          // of the ListView's bottom padding.
        ],
      ),
    );
  }
}