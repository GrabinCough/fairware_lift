// lib/src/features/today/presentation/today_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/today/application/today_state.dart';

import 'widgets/today_header.dart';
import 'widgets/start_continue_cta.dart';
// --- REMOVED ---
// import 'widgets/session_preview.dart';
// import 'widgets/recent_exercises.dart';
import 'widgets/prs_badge.dart';
// --- NEW IMPORTS ---
import 'widgets/last_workout_preview.dart';
import 'widgets/llm_prompt_builder_card.dart';


// -----------------------------------------------------------------------------
// --- TODAY SCREEN WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

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
      body: SafeArea(
        child: RefreshIndicator(
          // --- UPDATED: Refresh the correct provider ---
          onRefresh: () => ref.refresh(lastWorkoutProvider.future),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              AppTheme.sizing.baseGrid * 2,
              0,
              AppTheme.sizing.baseGrid * 2,
              100.0,
            ),
            children: [
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const TodayHeader(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const StartContinueCTA(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              // --- REPLACED WIDGETS ---
              const LastWorkoutPreview(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const LlmPromptBuilderCard(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              const PRsBadge(),
            ],
          ),
        ),
      ),
    );
  }
}