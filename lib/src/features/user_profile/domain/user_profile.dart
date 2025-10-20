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

/// --- UPDATED ---
/// The data model now includes fields that map directly to the LLM prompt's
/// USER CONTEXT block for more accurate prompt generation.
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
    String? trainingAge, // Renamed from experienceLevel
    List<String>? primaryGoals,
    String? goalDetails,

    // Schedule & Equipment
    int? daysPerWeek,
    int? timePerSessionMinutes,
    List<String>? equipmentAvailable,

    // Health & History
    String? constraints, // Renamed from injuryHistory
    String? currentStatus,

    // --- NEW FIELDS ---
    String? json1RMs, // To hold the JSON string for 1RMs
    int? z2LowBpm,
    int? z2HighBpm,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}