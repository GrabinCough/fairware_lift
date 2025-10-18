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
import 'package:fairware_lift/src/features/workout/domain/session_exercise.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT SUMMARY SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

class WorkoutSummaryScreen extends ConsumerWidget {
  final List<SessionExercise> completedExercises;

  const WorkoutSummaryScreen({
    super.key,
    required this.completedExercises,
  });

  /// --- SAVE WORKOUT LOGIC (UPGRADED) ---
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

    for (final exercise in completedExercises) {
      if (exercise.loggedSets.isNotEmpty) {
        // --- PERSIST ON FIRST USE ---
        exerciseInstancesToSave.add(
          ExerciseInstancesCompanion(
            slug: drift.Value(exercise.slug),
            familyId: drift.Value(exercise.discriminators['family_id'] ?? ''),
            displayName: drift.Value(exercise.displayName),
            discriminators: drift.Value(exercise.discriminators),
            firstSeenAt: drift.Value(now),
          ),
        );

        for (int i = 0; i < exercise.loggedSets.length; i++) {
          final set = exercise.loggedSets[i];
          setEntriesCompanion.add(
            SetEntriesCompanion(
              id: drift.Value(uuid.v4()),
              sessionId: drift.Value(sessionId),
              exerciseSlug: drift.Value(exercise.slug),
              setOrder: drift.Value(i + 1),
              weight: drift.Value(set.weight),
              reps: drift.Value(set.reps),
              createdAt: drift.Value(now),
              updatedAt: drift.Value(now),
            ),
          );
        }
      }
    }

    if (setEntriesCompanion.isEmpty) {
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
      await db.batch((batch) {
        batch.insertAll(db.setEntries, setEntriesCompanion);
      });
    });

    if (context.mounted) {
      // --- BUG FIX: No "Save" Feedback ---
      // We now `await` the result of showing the SnackBar. This ensures it is
      // visible for its full duration before we navigate away.
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
        itemCount: completedExercises.length,
        itemBuilder: (context, index) {
          final exercise = completedExercises[index];
          if (exercise.loggedSets.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildExerciseSummary(exercise);
        },
      ),
    );
  }

  Widget _buildExerciseSummary(SessionExercise exercise) {
    // ... (this method is unchanged)
    return Card(/* ... */);
  }
}