// lib/src/features/workout/presentation/widgets/warmup_list_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';

// -----------------------------------------------------------------------------
// --- WARMUP LIST ITEM WIDGET -------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple, stateless widget to display a warm-up item in the session list.
class WarmupListItem extends StatelessWidget {
  final WarmupItem warmupItem;

  const WarmupListItem({
    super.key,
    required this.warmupItem,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                warmupItem.displayName,
                style: AppTheme.typography.body
                    .copyWith(color: AppTheme.colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}