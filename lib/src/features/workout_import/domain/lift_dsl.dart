// lib/src/features/workout_import/domain/lift_dsl.dart

import 'package:flutter/foundation.dart';

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
  const Block({required this.type, this.label, this.rounds, required this.exercises});
}

@immutable
class Exercise {
  final String name;
  final Map<String, dynamic>? variation;
  final Prescription? prescription;
  final ExerciseMeta? metadata;
  final Info? info; // NEW
  const Exercise({required this.name, this.variation, this.prescription, this.metadata, this.info});
}

@immutable
class Prescription {
  final String? setType; // NEW
  final int? sets;
  final dynamic reps;
  final Intensity? intensity;
  final int? restSeconds;
  final int? restSecondsAfter;
  final String? note;
  const Prescription({this.setType, this.sets, this.reps, this.intensity, this.restSeconds, this.restSecondsAfter, this.note});
}

enum IntensityType { rpe, percent_1rm, load, rir }

@immutable
class Intensity {
  final IntensityType type;
  final double? target, value, kg, lb, rir;
  const Intensity({required this.type, this.target, this.value, this.kg, this.lb, this.rir});
}

@immutable
class ExerciseMeta {
  final List<String>? aliases, equipment, primaryMuscles;
  const ExerciseMeta({this.aliases, this.equipment, this.primaryMuscles});
}

// --- NEW ---
@immutable
class Info {
  final String? howTo;
  final List<String>? coachingCues;
  final List<String>? commonErrors;
  final String? safetyNotes;
  final String? videoSearchQuery;
  final String? webSearchQuery;
  final String? regression;
  final String? progression;
  final List<String>? muscles;
  final String? equipmentNotes;

  const Info({
    this.howTo,
    this.coachingCues,
    this.commonErrors,
    this.safetyNotes,
    this.videoSearchQuery,
    this.webSearchQuery,
    this.regression,
    this.progression,
    this.muscles,
    this.equipmentNotes,
  });
}