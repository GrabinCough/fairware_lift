// lib/src/features/workout_import/domain/lift_dsl.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
// --- DATA MODELS FOR LIFT DSL V1 ---------------------------------------------
// -----------------------------------------------------------------------------
// These classes directly map to the `lift.v1` JSON schema. They are used for
// parsing and validating the user's pasted workout text. Using immutable
// classes ensures data consistency throughout the import pipeline.
// -----------------------------------------------------------------------------

@immutable
class LiftWorkout {
  final String version;
  final Workout workout;

  const LiftWorkout({required this.version, required this.workout});
}

@immutable
class Workout {
  final String title;
  final String? notes;
  final List<Block> blocks;

  const Workout({required this.title, this.notes, required this.blocks});
}

enum BlockType { straight, superset, triset, warmup, finisher }

@immutable
class Block {
  final BlockType type;
  final String? label;
  final int? rounds;
  final List<Exercise> exercises;

  const Block({
    required this.type,
    this.label,
    this.rounds,
    required this.exercises,
  });
}

@immutable
class Exercise {
  final String name;
  final Map<String, dynamic>? variation;
  final Prescription? prescription;
  final ExerciseMeta? metadata;

  const Exercise({
    required this.name,
    this.variation,
    this.prescription,
    this.metadata,
  });
}

@immutable
class Prescription {
  final int? sets;
  final dynamic reps; // Can be String or int
  final Intensity? intensity;
  final int? restSeconds;
  final int? restSecondsAfter;
  final String? note;

  const Prescription({
    this.sets,
    this.reps,
    this.intensity,
    this.restSeconds,
    this.restSecondsAfter,
    this.note,
  });
}

enum IntensityType { rpe, percent_1rm, load, rir }

@immutable
class Intensity {
  final IntensityType type;
  final double? target; // For RPE
  final double? value; // For percent_1RM
  final double? kg;
  final double? lb;
  final double? rir; // For RIR

  const Intensity({
    required this.type,
    this.target,
    this.value,
    this.kg,
    this.lb,
    this.rir,
  });
}

@immutable
class ExerciseMeta {
  final List<String>? aliases;
  final List<String>? equipment;
  final List<String>? primaryMuscles;

  const ExerciseMeta({this.aliases, this.equipment, this.primaryMuscles});
}