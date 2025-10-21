// lib/src/features/workout/domain/logged_set.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'dart:convert';

// -----------------------------------------------------------------------------
// --- LOGGED SET DATA MODEL ---------------------------------------------------
// -----------------------------------------------------------------------------

/// A generic, immutable data class representing a single logged set for an exercise.
@immutable
class LoggedSet {
  final String id;
  final String setType; // "weight_reps", "timed", "distance", ...
  final double? weight; // in lb
  final int? reps;
  final int? durationSeconds;
  final int? distanceM;
  final int? calories;
  final double? rpe;
  final Map<String, dynamic> metrics; // incline, speed_mph, resistance_level, etc.
  final Map<String, dynamic>? prescriptionSnapshot;

  const LoggedSet({
    required this.id,
    required this.setType,
    this.weight,
    this.reps,
    this.durationSeconds,
    this.distanceM,
    this.calories,
    this.rpe,
    this.metrics = const {},
    this.prescriptionSnapshot,
  });

  factory LoggedSet.weightReps({
    required String id,
    required double weight,
    required int reps,
    double? rpe,
    Map<String, dynamic>? prescriptionSnapshot,
  }) =>
      LoggedSet(
        id: id,
        setType: 'weight_reps',
        weight: weight,
        reps: reps,
        rpe: rpe,
        prescriptionSnapshot: prescriptionSnapshot,
      );

  factory LoggedSet.timed({
    required String id,
    required int durationSeconds,
    Map<String, dynamic> metrics = const {},
    double? rpe,
    Map<String, dynamic>? prescriptionSnapshot,
  }) =>
      LoggedSet(
        id: id,
        setType: 'timed',
        durationSeconds: durationSeconds,
        metrics: metrics,
        rpe: rpe,
        prescriptionSnapshot: prescriptionSnapshot,
      );
}