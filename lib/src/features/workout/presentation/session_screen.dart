// lib/src/features/workout/presentation/session_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/dxg/presentation/dxg_exercise_picker_screen.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/presentation/widgets/exercise_list_item.dart';
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
    // ... (this method is unchanged)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            /* ... */
            );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionExercises = ref.watch(sessionStateProvider);

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
                    completedExercises: completedWorkout,
                  ),
                ),
              );
            },
            child: Text(
              'Finish',
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const WorkoutDock(),
      // --- UI UPGRADE: Reorderable List ---
      // The body is now a ListView that contains a ReorderableListView.
      // This allows for both reordering and having other widgets (like the
      // "Add Exercise" button) in the same scrollable view.
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
        children: [
          if (sessionExercises.isEmpty)
            _buildEmptyState()
          else
            ReorderableListView(
              // These properties are necessary when nesting a list view.
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // The callback that fires when a user finishes dragging an item.
              onReorder: (oldIndex, newIndex) {
                ref
                    .read(sessionStateProvider.notifier)
                    .reorderExercise(oldIndex, newIndex);
              },
              children: sessionExercises.map((exercise) {
                // --- UI UPGRADE: Swipe to Delete ---
                // Each item in the list is now wrapped in a Dismissible widget.
                return Dismissible(
                  // A unique key is required for each item.
                  key: ValueKey(exercise.id),
                  direction: DismissDirection.endToStart,
                  // The callback that fires when an item is swiped away.
                  onDismissed: (direction) {
                    ref
                        .read(sessionStateProvider.notifier)
                        .deleteExercise(exercise.id);
                  },
                  // The visual background that appears during the swipe.
                  background: Container(
                    color: AppTheme.colors.danger,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete_forever_rounded,
                        color: Colors.white),
                  ),
                  child: ExerciseListItem(
                    displayName: exercise.displayName,
                    discriminators: exercise.discriminators,
                    target: exercise.target,
                    loggedSets: exercise.loggedSets,
                    isCurrent: exercise.isCurrent,
                    onCardTap: () {
                      ref
                          .read(sessionStateProvider.notifier)
                          .setCurrentExercise(exercise.id);
                    },
                    onInfoTap: () => _showExerciseInfo(
                      context,
                      displayName: exercise.displayName,
                      discriminators: exercise.discriminators,
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () async {
              final result =
                  await Navigator.of(context).push<GeneratedExerciseResult>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const DXGExercisePickerScreen(),
                ),
              );
              if (result != null) {
                ref.read(sessionStateProvider.notifier).addDxgExercise(result);
              }
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Add Exercise'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.colors.accent,
            ),
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