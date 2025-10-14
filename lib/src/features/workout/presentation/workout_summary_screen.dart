// lib/src/features/workout/presentation/workout_summary_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// Riverpod for state management.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// The data models for the session.
import '../domain/session_exercise.dart';

// The database definition.
import 'package:fairware_lift/src/core/theme/data/local/database.dart';
import 'package:drift/drift.dart' as drift;

// Import the session state provider to reset it after saving.
import '../application/session_state.dart';

// Package for generating unique IDs for our database records.
import 'package:uuid/uuid.dart';

// -----------------------------------------------------------------------------
// --- WORKOUT SUMMARY SCREEN WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

/// A screen that displays a read-only summary of a completed workout session.
class WorkoutSummaryScreen extends ConsumerWidget {
  /// The list of exercises from the completed session.
  final List<SessionExercise> completedExercises;

  const WorkoutSummaryScreen({
    super.key,
    required this.completedExercises,
  });

  /// --- SAVE WORKOUT LOGIC ---
  Future<void> _saveWorkout(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    const uuid = Uuid();
    final now = DateTime.now();
    final sessionId = uuid.v4();

    // --- FIX ---
    // The parameter has been updated from `dateTime` to `sessionDateTime` to
    // match the corrected database table definition in `database.dart`.
    final sessionCompanion = SessionsCompanion(
      id: drift.Value(sessionId),
      sessionDateTime: drift.Value(now), // Corrected parameter name
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
    );

    final setEntriesCompanion = <SetEntriesCompanion>[];
    for (final exercise in completedExercises) {
      if (exercise.loggedSets.isNotEmpty) {
        for (int i = 0; i < exercise.loggedSets.length; i++) {
          final set = exercise.loggedSets[i];
          setEntriesCompanion.add(
            SetEntriesCompanion(
              id: drift.Value(uuid.v4()),
              sessionId: drift.Value(sessionId),
              exerciseName: drift.Value(exercise.name),
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
      await db.batch((batch) {
        batch.insertAll(db.setEntries, setEntriesCompanion);
      });
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout Saved!')),
      );
      ref.invalidate(sessionStateProvider);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        title: const Text('Workout Summary'),
        actions: [
          TextButton(
            onPressed: () => _saveWorkout(context, ref),
            child: Text(
              'Save',
              style: AppTheme.typography.body.copyWith(
                color: AppTheme.colors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
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

  /// A private helper to build the summary card for a single exercise.
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
              exercise.name,
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