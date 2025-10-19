// ----- lib/src/features/history/presentation/history_screen.dart -----
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

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  String _formatDuration(int totalSeconds) {
    if (totalSeconds < 0) return "0s";
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final parts = <String>[];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 || parts.isEmpty) parts.add('${seconds}s');
    return parts.join(' ');
  }

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
              return Dismissible(
                key: ValueKey(workout.session.id),
                direction: DismissDirection.endToStart,
                background: _buildDismissBackground(),
                confirmDismiss: (direction) async {
                  return await _showDeleteConfirmationDialog(context);
                },
                onDismissed: (direction) {
                  ref
                      .read(workoutHistoryProvider.notifier)
                      .deleteWorkout(workout.session.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Workout deleted')),
                  );
                },
                child: _buildWorkoutCard(context, workout),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: AppTheme.colors.danger,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.white,
      ),
    );
  }

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

  Widget _buildWorkoutCard(BuildContext context, FullWorkoutSession workout) {
    final setsByExercise =
        groupBy(workout.sets, (setWithExercise) => setWithExercise.exercise);
    final totalItems = setsByExercise.keys.length + workout.warmups.length;

    final subtitleParts = <String>[
      '$totalItems items',
      '${workout.sets.length} total sets',
    ];
    if (workout.session.totalDurationSeconds != null) {
      subtitleParts.add(_formatDuration(workout.session.totalDurationSeconds!));
    }
    final subtitle = subtitleParts.join('  •  ');

    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: ExpansionTile(
        title: Text(
          DateFormat.yMMMMd().add_jm().format(workout.session.sessionDateTime),
          style: AppTheme.typography.title.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.typography.caption,
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        children: [
          // --- REFACTORED ---
          // Now displays all three timing metrics if they are available.
          if (workout.session.totalDurationSeconds != null) ...[
            _buildTimingDetails(
              totalDuration: workout.session.totalDurationSeconds!,
              totalActivity: workout.session.totalActivitySeconds ?? 0,
              totalRest: workout.session.totalRestSeconds ?? 0,
            ),
            const Divider(height: 24),
          ],
          ...workout.warmups.map((warmup) => _buildWarmupSummary(warmup)),
          ...setsByExercise.entries.map((entry) {
            final exercise = entry.key;
            final sets = entry.value;
            return _buildExerciseSummary(context, exercise, sets);
          }),
        ],
      ),
    );
  }

  Widget _buildTimingDetails({required int totalDuration, required int totalActivity, required int totalRest}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('Duration', style: AppTheme.typography.caption),
              const SizedBox(height: 4),
              Text(_formatDuration(totalDuration), style: AppTheme.typography.body),
            ],
          ),
          Column(
            children: [
              Text('Activity', style: AppTheme.typography.caption),
              const SizedBox(height: 4),
              Text(_formatDuration(totalActivity), style: AppTheme.typography.body),
            ],
          ),
          Column(
            children: [
              Text('Rest', style: AppTheme.typography.caption),
              const SizedBox(height: 4),
              Text(_formatDuration(totalRest), style: AppTheme.typography.body),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarmupSummary(SavedWarmup warmup) {
    final subtitle = warmup.parameters.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('  •  ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            warmup.displayName,
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
    );
  }

  Widget _buildExerciseSummary(BuildContext context, ExerciseInstance exercise,
      List<SetEntryWithExercise> sets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  exercise.displayName,
                  style: AppTheme.typography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () => _showExerciseInfoDialog(context, exercise),
                color: AppTheme.colors.textMuted,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...sets.map((setWithExercise) {
            final set = setWithExercise.set;
            return Text(
              '  •  ${set.weight} lb x ${set.reps} reps',
              style: AppTheme.typography.body,
            );
          }),
        ],
      ),
    );
  }

  void _showExerciseInfoDialog(
      BuildContext context, ExerciseInstance exercise) {
    String _formatTitle(String key) =>
        '${key[0].toUpperCase()}${key.substring(1)}'.replaceAll('_', ' ');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.surface,
          title: Text(exercise.displayName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: exercise.discriminators.entries.map((entry) {
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