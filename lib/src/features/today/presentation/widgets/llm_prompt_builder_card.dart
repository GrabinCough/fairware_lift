// lib/src/features/today/presentation/widgets/llm_prompt_builder_card.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
// --- NEW IMPORT ---
import 'package:fairware_lift/src/features/llm_prompting/presentation/llm_intake_screen.dart';

// -----------------------------------------------------------------------------
// --- LLM PROMPT BUILDER CARD WIDGET ------------------------------------------
// -----------------------------------------------------------------------------

class LlmPromptBuilderCard extends StatelessWidget {
  const LlmPromptBuilderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'AI Prompt Builder',
            style: AppTheme.typography.title,
          ),
        ),
        Card(
          color: AppTheme.colors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildOption(
                  context: context, // Pass context
                  icon: Icons.person_add_alt_1_rounded,
                  title: 'Onboard New LLM',
                  subtitle: 'Create a profile to introduce yourself to a new AI coach.',
                  onTap: () {
                    // --- UPDATED: Navigate to the new screen ---
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LlmIntakeScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 24),
                _buildOption(
                  context: context,
                  icon: Icons.model_training_rounded,
                  title: "Get Today's Workout",
                  subtitle: 'Generate a prompt for a single workout session.',
                  onTap: () {
                    print("Get Today's Workout tapped");
                  },
                ),
                const Divider(height: 24),
                _buildOption(
                  context: context,
                  icon: Icons.calendar_view_week_rounded,
                  title: 'Plan My Week',
                  subtitle: 'Generate a prompt for a full weekly program.',
                  onTap: () {
                    print('Plan My Week tapped');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppTheme.colors.accent, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTheme.typography.caption.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppTheme.colors.textMuted),
        ],
      ),
    );
  }
}