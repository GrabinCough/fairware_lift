  // lib/src/features/workout_import/application/lift_dsl_validator.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';

// -----------------------------------------------------------------------------
// --- VALIDATION RESULT & SERVICE ---------------------------------------------
// -----------------------------------------------------------------------------

class ValidationResult {
  final LiftWorkout? workout;
  final String? error;

  ValidationResult({this.workout, this.error});

  bool get isValid => workout != null && error == null;
}

class LiftDslValidator {
  ValidationResult parseAndValidate(String jsonString) {
    try {
      final data = json.decode(jsonString) as Map<String, dynamic>;

      if (data['version'] != 'lift.v1') {
        return ValidationResult(error: 'Invalid or missing "version". Must be "lift.v1".');
      }
      if (data['workout'] == null || data['workout'] is! Map) {
        return ValidationResult(error: 'Missing or invalid "workout" object.');
      }

      final workoutData = data['workout'] as Map<String, dynamic>;
      final workout = _parseWorkout(workoutData);

      return ValidationResult(workout: LiftWorkout(version: 'lift.v1', workout: workout));
    } catch (e) {
      return ValidationResult(error: 'Invalid JSON format: ${e.toString()}');
    }
  }

  Workout _parseWorkout(Map<String, dynamic> data) {
    if (data['title'] == null || data['title'] is! String) {
      throw const FormatException('Workout missing required "title".');
    }
    if (data['blocks'] == null || data['blocks'] is! List) {
      throw const FormatException('Workout missing required "blocks" array.');
    }

    final blocks = (data['blocks'] as List).map((b) => _parseBlock(b as Map<String, dynamic>)).toList();

    return Workout(
      title: data['title'],
      notes: data['notes'] as String?,
      blocks: blocks,
    );
  }

  Block _parseBlock(Map<String, dynamic> data) {
    if (data['type'] == null || data['exercises'] == null) {
      throw const FormatException('Block is missing "type" or "exercises".');
    }
    
    final exercises = (data['exercises'] as List).map((e) => _parseExercise(e as Map<String, dynamic>)).toList();
    
    return Block(
      type: BlockType.values.firstWhere((e) => e.name == data['type']),
      label: data['label'] as String?,
      rounds: data['rounds'] as int?,
      exercises: exercises,
    );
  }

  Exercise _parseExercise(Map<String, dynamic> data) {
    if (data['name'] == null) {
      throw const FormatException('Exercise is missing required "name".');
    }
    return Exercise(
      name: data['name'],
      variation: data['variation'] as Map<String, dynamic>?,
      prescription: data['prescription'] != null ? _parsePrescription(data['prescription']) : null,
      metadata: data['metadata'] != null ? _parseExerciseMeta(data['metadata']) : null,
    );
  }

  Prescription _parsePrescription(Map<String, dynamic> data) {
    return Prescription(
      sets: data['sets'] as int?,
      reps: data['reps'],
      intensity: data['intensity'] != null ? _parseIntensity(data['intensity']) : null,
      restSeconds: data['rest_seconds'] as int?,
      restSecondsAfter: data['rest_seconds_after'] as int?,
      note: data['note'] as String?,
    );
  }

  Intensity _parseIntensity(Map<String, dynamic> data) {
    return Intensity(
      type: IntensityType.values.firstWhere((e) => e.name.toLowerCase().replaceAll('_', '') == data['type'].toString().toLowerCase().replaceAll('_', '')),
      target: (data['target'] as num?)?.toDouble(),
      value: (data['value'] as num?)?.toDouble(),
      kg: (data['kg'] as num?)?.toDouble(),
      lb: (data['lb'] as num?)?.toDouble(),
      rir: (data['rir'] as num?)?.toDouble(),
    );
  }

  ExerciseMeta _parseExerciseMeta(Map<String, dynamic> data) {
    return ExerciseMeta(
      aliases: (data['aliases'] as List?)?.map((e) => e.toString()).toList(),
      equipment: (data['equipment'] as List?)?.map((e) => e.toString()).toList(),
      primaryMuscles: (data['primary_muscles'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}