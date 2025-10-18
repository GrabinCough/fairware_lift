// lib/src/features/workout/domain/session_exercise.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// -----------------------------------------------------------------------------
// --- SESSION EXERCISE DATA MODEL ---------------------------------------------
// -----------------------------------------------------------------------------

/// An immutable data class representing a single exercise within an active
/// workout session.
@immutable
class SessionExercise {
  /// A unique identifier for this specific instance of the exercise in the session.
  final String id;

  // --- DATA MODEL UPGRADE ---
  /// The canonical, stable slug for the exercise (e.g., "press.dumbbell.incline").
  final String slug;

  /// The generated, human-readable name of the exercise (e.g., "Incline Dumbbell Press").
  final String displayName;

  /// The map of discriminators that define this exercise. Used for the info button.
  final Map<String, String> discriminators;

  /// The prescribed target for the exercise (e.g., "4 sets x 5-8 reps").
  final String target;

  /// The list of sets that the user has logged for this exercise.
  final List<LoggedSet> loggedSets;

  /// A flag to determine if this is the currently active exercise in the UI.
  final bool isCurrent;

  const SessionExercise({
    required this.id,
    required this.slug,
    required this.displayName,
    required this.discriminators,
    required this.target,
    this.loggedSets = const [],
    this.isCurrent = false,
  });

  /// A helper method to create a copy of this object with updated values.
  SessionExercise copyWith({
    String? id,
    String? slug,
    String? displayName,
    Map<String, String>? discriminators,
    String? target,
    List<LoggedSet>? loggedSets,
    bool? isCurrent,
  }) {
    return SessionExercise(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      displayName: displayName ?? this.displayName,
      discriminators: discriminators ?? this.discriminators,
      target: target ?? this.target,
      loggedSets: loggedSets ?? this.loggedSets,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}