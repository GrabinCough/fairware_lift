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

/// An immutable data model representing the user's fitness profile.
/// This data is collected in the LLM intake form and persisted locally.
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
    String? experienceLevel, // e.g., Beginner, Intermediate, Advanced
    List<String>? primaryGoals, // e.g., ['Build Muscle', 'Lose Fat']
    String? goalDetails,

    // Schedule & Equipment
    int? daysPerWeek,
    int? timePerSessionMinutes,
    List<String>? equipmentAvailable,

    // Health & History
    String? injuryHistory,
    String? currentStatus,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}