// lib/src/features/workout/presentation/widgets/exercise_list_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/set_sheet.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/timed_set_sheet.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE LIST ITEM WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

class ExerciseListItem extends ConsumerWidget {
  final String displayName;
  final Prescription prescription;
  final Map<String, dynamic> variation;
  final bool isCurrent;
  final List<LoggedSet> loggedSets;
  final VoidCallback onInfoTap;
  final VoidCallback onCardTap;
  final String? setType; // NEW: To determine which sheet to open.

  const ExerciseListItem({
    super.key,
    required this.displayName,
    required this.prescription,
    required this.variation,
    required this.loggedSets,
    required this.onInfoTap,
    required this.onCardTap,
    this.isCurrent = false,
    this.setType, // NEW
  });

  String _mmss(int? secs) {
    final s = secs ?? 0;
    final m = s ~/ 60;
    final r = s % 60;
    return '${m.toString().padLeft(1, '0')}:${r.toString().padLeft(2, '0')}';
  }

  String _fmtMetrics(Map<String, dynamic> m) {
    final incline = m['incline'];
    final speed = m['speed_mph'];
    final bits = <String>[];
    if (incline != null) bits.add('incline $incline');
    if (speed != null) bits.add('$speed mph');
    return bits.isEmpty ? '' : ' @ ${bits.join(' • ')}';
  }

  void _showSetSheet(BuildContext context, WidgetRef ref) async {
    // Logic to decide which sheet to show
    if (setType == 'timed') {
      final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => const TimedSetSheet(),
      );
      if (result != null) {
        ref.read(sessionStateProvider.notifier).logTimed(
              durationSeconds: result['durationSeconds'] as int,
              metrics: result['metrics'] as Map<String, dynamic>,
            );
      }
    } else {
      // Default to weight/reps
      final result = await showModalBottomSheet<Map<String, num>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => const SetSheet(),
      );
      if (result != null) {
        ref.read(sessionStateProvider.notifier).logWeightReps(
              weight: result['weight']!.toDouble(),
              reps: result['reps']!.toInt(),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                final details = switch (set.setType) {
                  'timed' => '${_mmss(set.durationSeconds)}${_fmtMetrics(set.metrics)}',
                  _ => '${set.weight} lb x ${set.reps} reps',
                };
                return _buildSetRow(
                  setNumber: index + 1,
                  details: details,
                );
              }),
              // --- NEW "ADD SET" BUTTON ---
              if (isCurrent) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showSetSheet(context, ref),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add Set'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.colors.accent.withOpacity(0.2),
                      foregroundColor: AppTheme.colors.accent,
                      elevation: 0,
                    ),
                  ),
                ),
              ],
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