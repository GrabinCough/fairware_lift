// lib/src/features/workout_import/application/lift_hash.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'package:crypto/crypto.dart';

// -----------------------------------------------------------------------------
// --- LIFT HASH SERVICE -------------------------------------------------------
// -----------------------------------------------------------------------------
// This service creates a stable, deterministic hash for an exercise based on
// its name and variation. This is crucial for identifying the same conceptual
// exercise over time, even if our internal slug system changes.
// -----------------------------------------------------------------------------

class LiftHash {
  /// Generates a stable SHA-1 hash for an exercise.
  ///
  /// The process is:
  /// 1. Normalize the exercise name to lowercase.
  /// 2. If variation exists, sort its keys alphabetically.
  /// 3. Create a canonical string representation (e.g., "bench press|grip:close|implement:barbell").
  /// 4. Hash this string using SHA-1.
  String exerciseHash(String rawName, Map<String, dynamic>? variation) {
    final normalizedName = rawName.trim().toLowerCase();
    final parts = [normalizedName];

    if (variation != null && variation.isNotEmpty) {
      final sortedKeys = variation.keys.toList()..sort();
      for (final key in sortedKeys) {
        final value = variation[key].toString().trim().toLowerCase();
        parts.add('$key:$value');
      }
    }

    final canonicalString = parts.join('|');
    final bytes = utf8.encode(canonicalString);
    final digest = sha1.convert(bytes);

    return digest.toString();
  }
}