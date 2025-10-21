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
import 'widgets/prs_badge.dart';
import 'widgets/last_workout_preview.dart';
// --- REMOVED: No longer need this import ---
// import 'widgets/llm_prompt_builder_card.dart';

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
              const LastWorkoutPreview(),
              SizedBox(height: AppTheme.sizing.verticalRhythm),
              // --- REMOVED: The LlmPromptBuilderCard is no longer displayed here ---
              const PRsBadge(),
            ],
          ),
        ),
      ),
    );
  }
}