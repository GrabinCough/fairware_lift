// lib/src/features/workout_import/application/lift_matcher.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/workout_import/application/text_norm.dart';

class MatchResult {
  final String? familyId;
  final double confidence;
  final bool unmapped;

  MatchResult({
    this.familyId,
    required this.confidence,
    this.unmapped = false,
  });
}

abstract class LiftMatcher {
  Future<MatchResult> match({
    required String rawName,
    List<String>? aliases,
  });
}

class RealLiftMatcher implements LiftMatcher {
  final Map<String, String> _lookupIndex;

  RealLiftMatcher(this._lookupIndex) {
    assert(_lookupIndex.isNotEmpty, 'RealLiftMatcher created with an empty lookup index.');
  }

  @override
  Future<MatchResult> match({
    required String rawName,
    List<String>? aliases,
  }) async {
    final namesToCheck = {
      normalize(rawName),
      ...?aliases?.map(normalize)
    };

    if (kDebugMode) {
      debugPrint('[LiftMatcher] Query: "$rawName" -> Normalized Candidates: ${namesToCheck.toList()}');
    }

    for (final name in namesToCheck) {
      if (_lookupIndex.containsKey(name)) {
        final familyId = _lookupIndex[name]!;
        if (kDebugMode) {
          debugPrint('  >>> HIT on "$name" -> familyId: "$familyId"');
        }
        return MatchResult(familyId: familyId, confidence: 1.0);
      }
    }

    if (kDebugMode) {
      debugPrint('  >>> MISS for all candidates.');
    }
    return MatchResult(confidence: 0.0, unmapped: true);
  }
}

final _lookupIndexProvider = FutureProvider<Map<String, String>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/data/lift_aliases.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
  
  final index = <String, String>{};

  for (final entry in jsonMap.entries) {
    final familyId = entry.key;
    final strings = List<String>.from(entry.value);
    for (final s in strings) {
      // Use the new variant generator to create a more robust index
      for (final v in variantsFor(s)) {
        index[v] = familyId;
      }
    }
  }

  if (index.isEmpty) {
    throw StateError('lift_aliases.json produced an empty lookup index.');
  }

  if (kDebugMode) {
    debugPrint('[LiftMatcher] Index built. Total unique keys: ${index.length}');
  }
  return index;
});

final liftMatcherProvider = FutureProvider<LiftMatcher>((ref) async {
  final lookupIndex = await ref.watch(_lookupIndexProvider.future);
  return RealLiftMatcher(lookupIndex);
});