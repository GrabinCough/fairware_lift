// ----- lib/src/features/workout/presentation/widgets/exercise_list_item.dart -----
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
import 'package:fairware_lift/src/features/workout/presentation/widgets/reps_only_set_sheet.dart';

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
  final String? setType;

  const ExerciseListItem({
    super.key,
    required this.displayName,
    required this.prescription,
    required this.variation,
    required this.loggedSets,
    required this.onInfoTap,
    required this.onCardTap,
    this.isCurrent = false,
    this.setType,
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

  void _showSetSheet(BuildContext context, WidgetRef ref, {LoggedSet? setToEdit}) async {
    final effectiveSetType = setToEdit?.setType ?? setType;

    if (effectiveSetType == 'timed') {
      final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => TimedSetSheet(set: setToEdit),
      );
      if (result != null) {
        final String? id = result['id'];
        if (id != null && setToEdit != null) {
          final updatedSet = setToEdit.copyWith(
            durationSeconds: result['durationSeconds'] as int,
            metrics: result['metrics'] as Map<String, dynamic>,
          );
          ref.read(sessionStateProvider.notifier).updateSet(updatedSet);
        } else {
          ref.read(sessionStateProvider.notifier).logTimed(
                durationSeconds: result['durationSeconds'] as int,
                metrics: result['metrics'] as Map<String, dynamic>,
              );
        }
      }
    } else if (effectiveSetType == 'reps_only') {
      final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => RepsOnlySetSheet(set: setToEdit),
      );
      if (result != null) {
        final String? id = result['id'];
        final reps = result['reps'] as int;
        if (id != null && setToEdit != null) {
          final updatedSet = setToEdit.copyWith(reps: reps);
          ref.read(sessionStateProvider.notifier).updateSet(updatedSet);
        } else {
          final bodyweight = result['weight'] as double;
          ref.read(sessionStateProvider.notifier).logRepsOnlySet(
                reps: reps,
                bodyweight: bodyweight,
              );
        }
      }
    } else { // Default to weight/reps
      final result = await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.colors.surface,
        builder: (context) => SetSheet(set: setToEdit),
      );
      if (result != null) {
        final String? id = result['id'];
        final weight = result['weight'] as double;
        final reps = result['reps'] as int;
        if (id != null && setToEdit != null) {
          final updatedSet = setToEdit.copyWith(weight: weight, reps: reps);
          ref.read(sessionStateProvider.notifier).updateSet(updatedSet);
        } else {
          ref.read(sessionStateProvider.notifier).logWeightReps(
                weight: weight,
                reps: reps,
              );
        }
      }
    }
  }

  // --- NEW: Confirmation dialog for deleting a set ---
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: const Text('Delete Set?'),
          content: const Text('Are you sure you want to delete this set? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Delete',
                style: TextStyle(color: AppTheme.colors.danger),
              ),
            ),
          ],
        );
      },
    );
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
                  'reps_only' => '${set.reps} reps',
                  _ => '${set.weight} lb x ${set.reps} reps',
                };
                return _buildSetRow(
                  context: context,
                  set: set,
                  setNumber: index + 1,
                  details: details,
                  onTap: () => _showSetSheet(context, ref, setToEdit: set),
                  onDismissed: () => ref.read(sessionStateProvider.notifier).deleteSet(setId: set.id),
                );
              }),
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

  Widget _buildSetRow({
    required BuildContext context,
    required LoggedSet set,
    required int setNumber,
    required String details,
    required VoidCallback onTap,
    required VoidCallback onDismissed,
  }) {
    return Dismissible(
      key: ValueKey(set.id),
      direction: DismissDirection.endToStart,
      // --- NEW: Added confirmation dialog ---
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmationDialog(context);
      },
      onDismissed: (_) => onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.danger,
          borderRadius: BorderRadius.circular(AppTheme.sizing.chipRadius),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete_sweep_rounded, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.sizing.chipRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.colors.background,
                  borderRadius: BorderRadius.circular(8),
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
              Expanded(
                child: Text(
                  details,
                  style: AppTheme.typography.body,
                ),
              ),
              Icon(
                Icons.edit_note_rounded,
                color: AppTheme.colors.surface, // Hidden until hovered
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}