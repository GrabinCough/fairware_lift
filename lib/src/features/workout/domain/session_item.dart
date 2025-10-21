// lib/src/features/workout/domain/session_item.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';

part 'session_item.freezed.dart';

@freezed
sealed class SessionItem with _$SessionItem {
  const factory SessionItem.exercise({
    required String id,
    String? slug,
    required String exerciseHash,
    required String displayName,
    required Prescription prescription,
    required Map<String, dynamic> variation,
    String? defaultSetType, // NEW
    Info? info,
    @Default([]) List<LoggedSet> loggedSets,
    @Default(false) bool isCurrent,
    @Default(false) bool unmapped,
  }) = SessionExercise;

  const factory SessionItem.warmup({
    required String id,
    required WarmupItem item,
    required Map<String, String> selectedParameters,
  }) = SessionWarmupItem;

  const factory SessionItem.superset({
    required String id,
    @Default([]) List<SessionExercise> exercises,
  }) = SessionSuperset;
}