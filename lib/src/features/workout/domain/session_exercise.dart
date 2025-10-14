// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Used for the @immutable annotation.
import 'package:flutter/foundation.dart';

// The data model for a single logged set.
import 'logged_set.dart';

// -----------------------------------------------------------------------------
// --- SESSION EXERCISE DATA MODEL ---------------------------------------------
// -----------------------------------------------------------------------------

/// An immutable data class representing a single exercise within an active
/// workout session.
///
/// This model holds all the information for one exercise in the user's current
/// workout, including its definition (name, target) and the user's performance
/// (the list of logged sets).
@immutable
class SessionExercise {
  /// A unique identifier for this specific instance of the exercise in the session.
  final String id;

  /// The name of the exercise (e.g., "Barbell Bench Press").
  final String name;

  /// The prescribed target for the exercise (e.g., "4 sets x 5-8 reps").
  final String target;

  /// The list of sets that the user has logged for this exercise.
  final List<LoggedSet> loggedSets;

  /// A flag to determine if this is the currently active exercise in the UI.
  final bool isCurrent;

  const SessionExercise({
    required this.id,
    required this.name,
    required this.target,
    this.loggedSets = const [], // Defaults to an empty list.
    this.isCurrent = false,
  });

  /// A helper method to create a copy of this object with updated values.
  ///
  /// Since this class is immutable, we use this method to create a new
  /// instance when we need to modify its state (e.g., adding a new set).
  /// This is a common pattern in state management.
  SessionExercise copyWith({
    String? id,
    String? name,
    String? target,
    List<LoggedSet>? loggedSets,
    bool? isCurrent,
  }) {
    return SessionExercise(
      id: id ?? this.id,
      name: name ?? this.name,
      target: target ?? this.target,
      loggedSets: loggedSets ?? this.loggedSets,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}