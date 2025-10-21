// lib/src/features/prompt_studio/presentation/widgets/prompt_card.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- PROMPT CARD WIDGET ------------------------------------------------------
// -----------------------------------------------------------------------------

/// A reusable card widget for the Prompt Studio main page, featuring a solid
/// color border and a clean, professional look.
class PromptCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon; // Reverted to IconData
  final Color color;
  final VoidCallback onTap;

  const PromptCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: AppTheme.colors.surface,
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          // --- MODIFIED: Replaced gradient with a solid border ---
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // --- MODIFIED: Reverted to Icon widget ---
            Icon(
              icon,
              size: 28,
              color: color,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.typography.title.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTheme.typography.body.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}