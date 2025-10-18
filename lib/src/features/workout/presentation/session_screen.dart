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

  /// Shows a dialog displaying the exercise's defining discriminators.
  void _showExerciseInfo(
    BuildContext context, {
    required String displayName,
    required Map<String, String> discriminators,
  }) {
    // ... (implementation is unchanged)
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- REFACTOR ---
    // The state now contains a list of the generic `SessionItem` type.
    final sessionItems = ref.watch(sessionStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Quick Workout'),
        actions: [
          TextButton(
            onPressed: () {
              // This needs to be updated to pass the new list type
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
                  // --- REFACTOR ---
                  // Use a switch statement on the `SessionItem` to determine
                  // which type of list item to render.
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
                        warmupItem: w.item,
                      ),
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () async {
              // --- REFACTOR ---
              // The result can now be a `GeneratedExerciseResult` or a `WarmupItem`.
              final result = await Navigator.of(context).push<Object>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const DXGExercisePickerScreen(),
                ),
              );

              // Check the type of the result and call the appropriate notifier method.
              if (result is GeneratedExerciseResult) {
                ref.read(sessionStateProvider.notifier).addDxgExercise(result);
              } else if (result is WarmupItem) {
                ref.read(sessionStateProvider.notifier).addWarmupItem(result);
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
    // ... (implementation is unchanged)
    return Center(/* ... */);
  }
}