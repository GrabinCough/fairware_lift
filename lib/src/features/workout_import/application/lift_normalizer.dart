  // lib/src/features/workout_import/application/lift_normalizer.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';

// -----------------------------------------------------------------------------
// --- LIFT NORMALIZER SERVICE -------------------------------------------------
// -----------------------------------------------------------------------------

class LiftNormalizer {
  LiftWorkout normalize(LiftWorkout rawWorkout) {
    final normalizedBlocks = rawWorkout.workout.blocks.map((block) {
      final bool isMultiExerciseBlock =
          block.type == BlockType.superset || block.type == BlockType.triset;

      final normalizedExercises = block.exercises.map((exercise) {
        final normalizedPrescription = _normalizePrescription(
          exercise.prescription,
          isMultiExerciseBlock: isMultiExerciseBlock,
          rounds: block.rounds,
        );

        return Exercise(
          name: exercise.name,
          variation: exercise.variation,
          prescription: normalizedPrescription,
          metadata: exercise.metadata,
        );
      }).toList();

      return Block(
        type: block.type,
        label: block.label,
        rounds: block.rounds,
        exercises: normalizedExercises,
      );
    }).toList();

    return LiftWorkout(
      version: rawWorkout.version,
      workout: Workout(
        title: rawWorkout.workout.title,
        notes: rawWorkout.workout.notes,
        blocks: normalizedBlocks,
      ),
    );
  }

  Prescription _normalizePrescription(
    Prescription? rawPrescription, {
    required bool isMultiExerciseBlock,
    int? rounds,
  }) {
    final p = rawPrescription ?? const Prescription();
    final sets = p.sets ?? (isMultiExerciseBlock ? rounds : 3);

    return Prescription(
      sets: sets,
      reps: p.reps ?? '8-12',
      intensity: p.intensity,
      restSeconds: p.restSeconds,
      restSecondsAfter: p.restSecondsAfter,
      note: p.note,
    );
  }
}