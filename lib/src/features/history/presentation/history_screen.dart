// lib/src/features/history/presentation/history_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/history/application/history_state.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

// -----------------------------------------------------------------------------
// --- HISTORY SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for displaying a log of all past workouts.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(workoutHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (workouts) {
          if (workouts.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              // --- UI FIX ---
              // Each card is now wrapped in a Dismissible widget.
              return Dismissible(
                key: ValueKey(workout.session.id),
                direction: DismissDirection.endToStart,
                background: _buildDismissBackground(),
                // This function is called before the item is dismissed.
                // It shows a confirmation dialog.
                confirmDismiss: (direction) async {
                  return await _showDeleteConfirmationDialog(context);
                },
                // This function is called after the dismiss is confirmed.
                onDismissed: (direction) {
                  ref.read(workoutHistoryProvider.notifier).deleteWorkout(workout.session.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Workout deleted')),
                  );
                },
                child: _buildWorkoutCard(workout),
              );
            },
          );
        },
      ),
    );
  }

  /// Builds the red background that appears behind the card during a swipe.
  Widget _buildDismissBackground() {
    return Container(
      color: AppTheme.colors.danger,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.white,
      ),
    );
  }

  /// Shows an AlertDialog to confirm the deletion.
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: const Text('Delete Workout?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Dismiss and return false
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Dismiss and return true
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

  /// Builds the card for a single workout session.
  Widget _buildWorkoutCard(FullWorkoutSession workout) {
    final setsByExercise = groupBy(workout.sets, (set) => set.exerciseName);

    return Card(
      color: AppTheme.colors.surface,
      margin: EdgeInsets.zero, // Margin is now handled by the Dismissible's background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: ExpansionTile(
        title: Text(
          DateFormat.yMMMMd().add_jm().format(workout.session.sessionDateTime),
          style: AppTheme.typography.title.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          '${setsByExercise.keys.length} exercises, ${workout.sets.length} total sets',
          style: AppTheme.typography.caption,
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        children: setsByExercise.entries.map((entry) {
          final exerciseName = entry.key;
          final sets = entry.value;
          return _buildExerciseSummary(exerciseName, sets);
        }).toList(),
      ),
    );
  }

  /// Builds the summary for a single exercise within a workout card.
  Widget _buildExerciseSummary(String name, List<SetEntry> sets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTheme.typography.body.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          ...sets.map((set) {
            return Text(
              '  •  ${set.weight} lb x ${set.reps} reps',
              style: AppTheme.typography.body,
            );
          }),
        ],
      ),
    );
  }

  /// Builds the "Empty State" UI when no workouts are found.
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 80,
              color: AppTheme.colors.textMuted,
            ),
            const SizedBox(height: 24),
            Text(
              'No workouts logged yet.',
              style: AppTheme.typography.title.copyWith(
                color: AppTheme.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}