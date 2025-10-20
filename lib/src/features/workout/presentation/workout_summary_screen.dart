// lib/src/features/workout/presentation/workout_summary_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/core/theme/data/local/database.dart';
import 'package:fairware_lift/src/features/workout/application/session_state.dart';
import 'package:fairware_lift/src/features/workout/application/timer_state.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT SUMMARY SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

class WorkoutSummaryScreen extends ConsumerWidget {
  final List<SessionItem> completedItems;

  const WorkoutSummaryScreen({
    super.key,
    required this.completedItems,
  });

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

  Future<void> _saveWorkout(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final metrics = ref.read(workoutMetricsProvider);
    const uuid = Uuid();
    final now = DateTime.now();
    final sessionId = uuid.v4();

    final sessionCompanion = SessionsCompanion(
      id: drift.Value(sessionId),
      sessionDateTime: drift.Value(now),
      totalDurationSeconds: drift.Value(metrics.totalDurationSeconds),
      totalActivitySeconds: drift.Value(metrics.totalActivitySeconds),
      totalRestSeconds: drift.Value(metrics.totalRestSeconds),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    final setEntriesCompanion = <SetEntriesCompanion>[];
    final exerciseInstancesToSave = <ExerciseInstancesCompanion>[];
    final savedWarmupsCompanion = <SavedWarmupsCompanion>[];

    for (final item in completedItems) {
      switch (item) {
        case SessionExercise e when e.loggedSets.isNotEmpty && !e.unmapped:
          _processExerciseForSaving(e, sessionId, now, exerciseInstancesToSave, setEntriesCompanion);
        case SessionWarmupItem w:
          savedWarmupsCompanion.add(
            SavedWarmupsCompanion(
              id: drift.Value(uuid.v4()),
              sessionId: drift.Value(sessionId),
              warmupId: drift.Value(w.item.id),
              displayName: drift.Value(w.item.displayName),
              parameters: drift.Value(w.selectedParameters),
              createdAt: drift.Value(now),
            ),
          );
        case SessionSuperset s:
          for (final exerciseInSuperset in s.exercises) {
            if (exerciseInSuperset.loggedSets.isNotEmpty && !exerciseInSuperset.unmapped) {
              _processExerciseForSaving(exerciseInSuperset, sessionId, now, exerciseInstancesToSave, setEntriesCompanion);
            }
          }
        case _:
      }
    }

    if (setEntriesCompanion.isEmpty && savedWarmupsCompanion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empty or unmapped workout discarded.')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    await db.transaction(() async {
      await db.into(db.sessions).insert(sessionCompanion);
      for (final instance in exerciseInstancesToSave) {
        await db.into(db.exerciseInstances).insertOnConflictUpdate(instance);
      }
      if (setEntriesCompanion.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(db.setEntries, setEntriesCompanion);
        });
      }
      if (savedWarmupsCompanion.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(db.savedWarmups, savedWarmupsCompanion);
        });
      }
    });

    if (context.mounted) {
      await ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(content: Text('Workout Saved!')),
          )
          .closed;
      ref.invalidate(sessionStateProvider);
      ref.invalidate(workoutMetricsProvider);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _processExerciseForSaving(
    SessionExercise e,
    String sessionId,
    DateTime now,
    List<ExerciseInstancesCompanion> exerciseInstancesToSave,
    List<SetEntriesCompanion> setEntriesCompanion,
  ) {
    // Guard against unmapped exercises which will have a null slug.
    if (e.slug == null) return;

    const uuid = Uuid();
    final familyId = e.slug!.split('.').first;
    final discriminators = e.variation.map((key, value) => MapEntry(key, value.toString()));

    exerciseInstancesToSave.add(
      ExerciseInstancesCompanion(
        slug: drift.Value(e.slug!),
        familyId: drift.Value(familyId),
        displayName: drift.Value(e.displayName),
        discriminators: drift.Value(discriminators),
        firstSeenAt: drift.Value(now),
      ),
    );
    for (int i = 0; i < e.loggedSets.length; i++) {
      final set = e.loggedSets[i];
      setEntriesCompanion.add(
        SetEntriesCompanion(
          id: drift.Value(uuid.v4()),
          sessionId: drift.Value(sessionId),
          exerciseSlug: drift.Value(e.slug!),
          setOrder: drift.Value(i + 1),
          weight: drift.Value(set.weight),
          reps: drift.Value(set.reps),
          createdAt: drift.Value(now),
          updatedAt: drift.Value(now),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(workoutMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Summary'),
        actions: [
          TextButton(
            onPressed: () => _saveWorkout(context, ref),
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildMetricsCard(metrics),
          ...completedItems.map((item) {
            return switch (item) {
              SessionExercise e when e.loggedSets.isNotEmpty =>
                _buildExerciseSummary(e),
              SessionWarmupItem w => _buildWarmupSummary(w),
              SessionSuperset s when s.exercises.any((e) => e.loggedSets.isNotEmpty) =>
                _buildSupersetSummary(s),
              _ => const SizedBox.shrink(),
            };
          }),
        ],
      ),
    );
  }

  Widget _buildMetricsCard(WorkoutMetrics metrics) {
    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricItem(
              icon: Icons.timer_outlined,
              label: 'Duration',
              value: _formatDuration(metrics.totalDurationSeconds),
            ),
            _buildMetricItem(
              icon: Icons.local_fire_department_outlined,
              label: 'Activity',
              value: _formatDuration(metrics.totalActivitySeconds),
            ),
            _buildMetricItem(
              icon: Icons.pause_circle_outline,
              label: 'Rest',
              value: _formatDuration(metrics.totalRestSeconds),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.colors.textMuted, size: 28),
        const SizedBox(height: 8),
        Text(label, style: AppTheme.typography.caption),
        const SizedBox(height: 4),
        Text(value, style: AppTheme.typography.title.copyWith(fontSize: 18)),
      ],
    );
  }

  Widget _buildExerciseSummary(SessionExercise exercise) {
    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.displayName,
              style: AppTheme.typography.title.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 12),
            ...exercise.loggedSets.asMap().entries.map((entry) {
              final setIndex = entry.key + 1;
              final set = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  'Set $setIndex: ${set.weight} lb x ${set.reps} reps',
                  style: AppTheme.typography.body,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildWarmupSummary(SessionWarmupItem warmup) {
    final subtitle = warmup.selectedParameters.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('  ΓÇó  ');

    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              warmup.item.displayName,
              style: AppTheme.typography.body
                  .copyWith(color: AppTheme.colors.textPrimary),
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
    );
  }

  Widget _buildSupersetSummary(SessionSuperset superset) {
    return Card(
      color: AppTheme.colors.surface,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
        side: BorderSide(color: AppTheme.colors.surfaceAlt, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.link_rounded, color: AppTheme.colors.textMuted),
                const SizedBox(width: 8),
                Text(
                  'Superset',
                  style: AppTheme.typography.title.copyWith(fontSize: 20),
                ),
              ],
            ),
            const Divider(height: 24),
            ...superset.exercises.where((e) => e.loggedSets.isNotEmpty).map((exercise) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.displayName,
                      style: AppTheme.typography.body.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...exercise.loggedSets.asMap().entries.map((entry) {
                      final setIndex = entry.key + 1;
                      final set = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                        child: Text(
                          'Set $setIndex: ${set.weight} lb x ${set.reps} reps',
                          style: AppTheme.typography.body,
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}