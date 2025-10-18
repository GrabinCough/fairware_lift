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
        // Add this exercise to the list of instances to be saved.
        // `insertOnConflictUpdate` will create it if the slug doesn't exist,
        // or do nothing if it already does.
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
              // --- DATA MODEL UPGRADE ---
              // Save the stable slug instead of the display name.
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
      // ... (unchanged)
      return;
    }

    // Perform all database writes in a single transaction for data integrity.
    await db.transaction(() async {
      await db.into(db.sessions).insert(sessionCompanion);
      
      // Save all the exercise instances.
      for (final instance in exerciseInstancesToSave) {
        await db.into(db.exerciseInstances).insertOnConflictUpdate(instance);
      }
      
      // Batch insert all the set entries.
      await db.batch((batch) {
        batch.insertAll(db.setEntries, setEntriesCompanion);
      });
    });

    if (context.mounted) {
      // ... (rest of method is unchanged)
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
              exercise.displayName, // Use displayName
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
}