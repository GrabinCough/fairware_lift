// lib/src/features/workout/domain/session_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

part 'session_item.freezed.dart';

// -----------------------------------------------------------------------------
// --- SESSION ITEM DATA MODEL (REFACTOR) --------------------------------------
// -----------------------------------------------------------------------------

@freezed
sealed class SessionItem with _$SessionItem {
  /// Represents a strength training exercise with loggable sets.
  const factory SessionItem.exercise({
    required String id,
    required String slug,
    required String displayName,
    required Map<String, String> discriminators,
    required String target,
    @Default([]) List<LoggedSet> loggedSets,
    @Default(false) bool isCurrent,
  }) = SessionExercise;

  /// Represents a warm-up or prep item with its selected parameters.
  const factory SessionItem.warmup({
    required String id,
    required WarmupItem item,
    // --- NEW ---
    // Stores the user's selections, e.g., {'Grip': 'Wide'}
    required Map<String, String> selectedParameters,
  }) = SessionWarmupItem;
}