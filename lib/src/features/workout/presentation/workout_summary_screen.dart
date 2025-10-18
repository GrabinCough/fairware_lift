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

  Future<void> _saveWorkout(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    const uuid = Uuid();
    final now = DateTime.now();
    final sessionId = uuid.v4();

    final sessionCompanion = SessionsCompanion(
      id: drift.Value(sessionId),
      sessionDateTime: drift.Value(now),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    final setEntriesCompanion = <SetEntriesCompanion>[];
    final exerciseInstancesToSave = <ExerciseInstancesCompanion>[];
    final savedWarmupsCompanion = <SavedWarmupsCompanion>[];

    for (final item in completedItems) {
      switch (item) {
        case SessionExercise e when e.loggedSets.isNotEmpty:
          exerciseInstancesToSave.add(
            ExerciseInstancesCompanion(
              slug: drift.Value(e.slug),
              familyId: drift.Value(e.discriminators['family_id'] ?? ''),
              displayName: drift.Value(e.displayName),
              discriminators: drift.Value(e.discriminators),
              firstSeenAt: drift.Value(now),
            ),
          );
          for (int i = 0; i < e.loggedSets.length; i++) {
            final set = e.loggedSets[i];
            setEntriesCompanion.add(
              SetEntriesCompanion(
                id: drift.Value(uuid.v4()),
                sessionId: drift.Value(sessionId),
                exerciseSlug: drift.Value(e.slug),
                setOrder: drift.Value(i + 1),
                weight: drift.Value(set.weight),
                reps: drift.Value(set.reps),
                createdAt: drift.Value(now),
                updatedAt: drift.Value(now),
              ),
            );
          }
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
        case _:
      }
    }

    if (setEntriesCompanion.isEmpty && savedWarmupsCompanion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empty workout discarded.')),
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: completedItems.length,
        itemBuilder: (context, index) {
          final item = completedItems[index];
          return switch (item) {
            SessionExercise e when e.loggedSets.isNotEmpty =>
              _buildExerciseSummary(e),
            SessionWarmupItem w => _buildWarmupSummary(w),
            _ => const SizedBox.shrink(),
          };
        },
      ),
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
        .map((e) => e.value)
        .join(' • ');

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
}