// lib/src/features/workout/presentation/widgets/exercise_list_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE LIST ITEM WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

class ExerciseListItem extends StatelessWidget {
  final String displayName;
  final Prescription prescription;
  final Map<String, dynamic> variation;
  final bool isCurrent;
  final List<LoggedSet> loggedSets;
  final VoidCallback onInfoTap;
  final VoidCallback onCardTap;

  const ExerciseListItem({
    super.key,
    required this.displayName,
    required this.prescription,
    required this.variation,
    required this.loggedSets,
    required this.onInfoTap,
    required this.onCardTap,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final reps = prescription.reps?.toString() ?? '';
    final sets = prescription.sets?.toString() ?? '';
    final targetString = (sets.isNotEmpty && reps.isNotEmpty) ? '$sets x $reps' : reps;

    return Card(
      color: isCurrent ? AppTheme.colors.surfaceAlt : AppTheme.colors.surface,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        side: isCurrent
            ? BorderSide(color: AppTheme.colors.accent, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onCardTap,
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      displayName,
                      style: AppTheme.typography.title.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Text(
                        targetString,
                        style: AppTheme.typography.body,
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.info_outline_rounded),
                        onPressed: onInfoTap,
                        color: AppTheme.colors.textMuted,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...loggedSets.asMap().entries.map((entry) {
                final index = entry.key;
                final set = entry.value;
                return _buildSetRow(
                  setNumber: index + 1,
                  details: '${set.weight} lb x ${set.reps} reps',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetRow({required int setNumber, required String details}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.colors.background,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              setNumber.toString(),
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            details,
            style: AppTheme.typography.body,
          ),
        ],
      ),
    );
  }
}