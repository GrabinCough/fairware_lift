// lib/src/features/workout_import/application/text_norm.dart

// -----------------------------------------------------------------------------
// --- NORMALIZATION & VARIANT GENERATION --------------------------------------
// -----------------------------------------------------------------------------

/// A robust normalization function to clean up strings for matching.
String normalize(String s) {
  return s
      .toLowerCase()
      // Strip all characters that are not letters, numbers, or spaces.
      .replaceAll(RegExp(r"[^\p{L}\p{N}\s]+", unicode: true), " ")
      // Collapse multiple whitespace characters into a single space.
      .replaceAll(RegExp(r"\s+"), " ")
      .trim();
}

/// Generates multiple searchable variations of a given exercise name.
Iterable<String> variantsFor(String original) sync* {
  final base = normalize(original);
  yield base;

  // Variant with parenthetical notes removed, e.g., "Nordic Curl (Assisted)" -> "nordic curl"
  final noParens = base.replaceAll(RegExp(r"\([^)]*\)"), "").replaceAll(RegExp(r"\s+"), " ").trim();
  if (noParens != base) {
    yield noParens;
  }

  // Variant with common equipment tokens removed.
  final noEquip = noParens.replaceAll(
      RegExp(r"\b(machine|barbell|dumbbell|db|cable|assisted|ez bar|ez-bar|ezbar)\b"),
      "").replaceAll(RegExp(r"\s+"), " ").trim();
  if (noEquip.isNotEmpty && noEquip != noParens) {
    yield noEquip;
  }
}