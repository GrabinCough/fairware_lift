// lib/src/features/today/presentation/today_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
// --- NEW IMPORT ---
import 'package:fairware_lift/src/features/today/application/today_state.dart';

import 'widgets/today_header.dart';
import 'widgets/start_continue_cta.dart';
import 'widgets/session_preview.dart';
import 'widgets/recent_exercises.dart';
import 'widgets/prs_badge.dart';

// -----------------------------------------------------------------------------
// --- TODAY SCREEN WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// The primary landing screen for the user, now with pull-to-refresh.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      // --- REFACTORED ---
      // The body is now wrapped in a RefreshIndicator to allow pull-to-refresh.
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(recentExercisesProvider.future),
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
      ),
    );
  }
}