// ----- lib/src/features/workout/domain/session_item.dart -----
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
  /// Represents a standalone strength training exercise.
  const factory SessionItem.exercise({
    required String id,
    required String slug,
    required String displayName,
    required Map<String, String> discriminators,
    required String target,
    @Default([]) List<LoggedSet> loggedSets,
    @Default(false) bool isCurrent,
  }) = SessionExercise;

  /// Represents a warm-up or prep item.
  const factory SessionItem.warmup({
    required String id,
    required WarmupItem item,
    required Map<String, String> selectedParameters,
  }) = SessionWarmupItem;

  /// --- NEW ---
  /// Represents a superset block, which contains a list of exercises.
  const factory SessionItem.superset({
    required String id,
    @Default([]) List<SessionExercise> exercises,
  }) = SessionSuperset;
}