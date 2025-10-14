// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Used for the @immutable annotation.
import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
// --- LOGGED SET DATA MODEL ---------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple, immutable data class representing a single logged set for an exercise.
///
/// This class acts as a data model for our application state. It holds the
/// information about a set that has been completed by the user.
@immutable
class LoggedSet {
  /// The weight used for the set.
  final double weight;

  /// The number of repetitions performed.
  final int reps;

  /// A unique identifier for the set, typically generated when the set is created.
  final String id;

  const LoggedSet({
    required this.weight,
    required this.reps,
    required this.id,
  });
}