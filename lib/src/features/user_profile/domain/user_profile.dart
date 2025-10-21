// lib/src/features/user_profile/domain/user_profile.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

// -----------------------------------------------------------------------------
// --- USER PROFILE DATA MODEL -------------------------------------------------
// -----------------------------------------------------------------------------

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    // Basic Info
    String? name,
    int? age,
    String? gender,
    int? heightInches,
    double? weightLbs,

    // Experience & Goals
    String? trainingAge,
    List<String>? primaryGoals,
    String? goalDetails,

    // --- NEW FIELD ---
    String? motivationStyle,

    // Schedule & Equipment
    int? daysPerWeek,
    int? timePerSessionMinutes,
    List<String>? equipmentAvailable,

    // Health & History
    String? constraints,
    String? currentStatus,
    String? json1RMs,
    int? z2LowBpm,
    int? z2HighBpm,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}