// lib/src/features/workout/presentation/session_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';
import 'package:fairware_lift/src/features/dxg/presentation/dxg_exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/exercise_list_item.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/warmup_list_item.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/workout_dock.dart';
import 'package:fairware_lift/src/features/workout/presentation/workout_summary_screen.dart';

// -----------------------------------------------------------------------------
// --- SESSION SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  void _showExerciseInfo(
    BuildContext context, {
    required String displayName,
    required Map<String, String> discriminators,
  }) {
    String _formatTitle(String key) =>
        '${key[0].toUpperCase()}${key.substring(1)}';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: Text(displayName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: discriminators.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.typography.body,
                    children: [
                      TextSpan(
                        text: '${_formatTitle(entry.key)}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: entry.value),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionItems = ref.watch(sessionStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Quick Workout'),
        actions: [
          TextButton(
            onPressed: () {
              final completedWorkout = ref.read(sessionStateProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkoutSummaryScreen(
                    completedItems: completedWorkout,
                  ),
                ),
              );
            },
            child: const Text('Finish'),
          ),
        ],
      ),
      bottomNavigationBar: const WorkoutDock(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
        children: [
          if (sessionItems.isEmpty)
            _buildEmptyState()
          else
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                ref
                    .read(sessionStateProvider.notifier)
                    .reorderItem(oldIndex, newIndex);
              },
              children: sessionItems.map((item) {
                return Dismissible(
                  key: ValueKey(item.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ref.read(sessionStateProvider.notifier).deleteItem(item.id);
                  },
                  background: Container(
                    color: AppTheme.colors.danger,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete_forever_rounded),
                  ),
                  child: switch (item) {
                    SessionExercise e => ExerciseListItem(
                        displayName: e.displayName,
                        discriminators: e.discriminators,
                        target: e.target,
                        loggedSets: e.loggedSets,
                        isCurrent: e.isCurrent,
                        onCardTap: () {
                          ref
                              .read(sessionStateProvider.notifier)
                              .setCurrentItem(e.id);
                        },
                        onInfoTap: () => _showExerciseInfo(
                          context,
                          displayName: e.displayName,
                          discriminators: e.discriminators,
                        ),
                      ),
                    SessionWarmupItem w => WarmupListItem(
                        warmup: w,
                      ),
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () async {
              final result = await Navigator.of(context).push<dynamic>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const DXGExercisePickerScreen(),
                ),
              );

              if (result is GeneratedExerciseResult) {
                ref.read(sessionStateProvider.notifier).addDxgExercise(result);
              } else if (result is Map) {
                final item = result['item'] as WarmupItem;
                final params = result['params'] as Map<String, String>;
                ref.read(sessionStateProvider.notifier).addWarmupItem(item, params);
              }
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add Exercise'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0),
        child: Column(
          children: [
            Icon(
              Icons.fitness_center_rounded,
              size: 64,
              color: AppTheme.colors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Your session is empty.',
              style: AppTheme.typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap "Add Exercise" to get started.',
              style: AppTheme.typography.body,
            ),
          ],
        ),
      ),
    );
  }
}