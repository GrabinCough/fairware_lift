// ----- lib/src/features/workout/presentation/widgets/warmup_list_item.dart -----
// lib/src/features/workout/presentation/widgets/warmup_list_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';

// -----------------------------------------------------------------------------
// --- WARMUP LIST ITEM WIDGET -------------------------------------------------
// -----------------------------------------------------------------------------

class WarmupListItem extends StatelessWidget {
  final SessionWarmupItem warmup;

  const WarmupListItem({
    super.key,
    required this.warmup,
  });

  @override
  Widget build(BuildContext context) {
    // --- BUG FIX ---
    // The subtitle now correctly formats each parameter as "Key: Value".
    // This fixes the issue where only the value was shown (e.g., "5.0" instead
    // of "Incline: 5.0") and ensures all selected parameters are visible.
    final subtitle = warmup.selectedParameters.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('  •  ');

    return Card(
      color: AppTheme.colors.surface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.self_improvement,
              color: AppTheme.colors.textMuted,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warmup.item.displayName,
                    style: AppTheme.typography.body
                        .copyWith(color: AppTheme.colors.textSecondary),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTheme.typography.caption,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}