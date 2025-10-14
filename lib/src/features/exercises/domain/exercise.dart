// lib/src/features/exercises/domain/exercise.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
// --- EXERCISE DATA MODEL -----------------------------------------------------
// -----------------------------------------------------------------------------

/// An immutable data class representing a single exercise definition from the library.
///
/// This model holds all the detailed information for an exercise, parsed from
/// the `fairware_exercise_library.csv` asset.
@immutable
class Exercise {
  final String name;
  final String equipment;
  final String movementPattern;
  final String primaryMuscles;
  final String secondaryMuscles;
  final String howTo;

  const Exercise({
    required this.name,
    required this.equipment,
    required this.movementPattern,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.howTo,
  });

  /// A factory constructor to create an Exercise instance from a CSV row (represented as a List<dynamic>).
  factory Exercise.fromCsvRow(List<dynamic> row) {
    return Exercise(
      name: row[0].toString(),
      equipment: row[1].toString(),
      movementPattern: row[2].toString(),
      primaryMuscles: row[3].toString(),
      secondaryMuscles: row[4].toString(),
      howTo: row[5].toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Exercise{name: $name}';
  }
}