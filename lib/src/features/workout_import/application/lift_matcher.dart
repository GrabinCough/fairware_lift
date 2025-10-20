 // lib/src/features/workout_import/application/lift_matcher.dart

// -----------------------------------------------------------------------------
// --- MATCHER DATA MODELS & INTERFACE -----------------------------------------
// -----------------------------------------------------------------------------
// Defines the contract for the 3-stage matching engine. This allows us to
// build the rest of the pipeline while developing the matching logic in parallel.
// -----------------------------------------------------------------------------

/// The output of a matching attempt.
class MatchResult {
  final String? canonicalSlug;
  final double confidence;
  final bool unmapped;

  MatchResult({
    this.canonicalSlug,
    required this.confidence,
    this.unmapped = false,
  });
}

/// Abstract interface for the matching service.
abstract class LiftMatcher {
  /// Attempts to find a canonical `MovementFamily` slug for a given exercise name.
  Future<MatchResult> match({
    required String rawName,
    List<String>? aliases,
    Map<String, dynamic>? variation,
  });
}

/// A stub implementation for development and testing.
/// This allows the rest of the app to be built without a fully functional matcher.
class StubLiftMatcher implements LiftMatcher {
  @override
  Future<MatchResult> match({
    required String rawName,
    List<String>? aliases,
    Map<String, dynamic>? variation,
  }) async {
    // In the stub, we'll just pretend we couldn't find a match.
    // This forces us to build and test the "unmapped" and "low confidence" UI paths.
    return MatchResult(
      confidence: 0.1, // Simulate very low confidence
      unmapped: true,
    );
  }
}