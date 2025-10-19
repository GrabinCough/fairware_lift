// ----- lib/src/features/dxg/domain/movement_family.dart -----
// lib/src/features/dxg/domain/movement_family.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fairware_lift/src/features/dxg/domain/dxg_enums.dart';

part 'movement_family.freezed.dart';
part 'movement_family.g.dart';

// -----------------------------------------------------------------------------
// --- MOVEMENT FAMILY DATA MODEL ----------------------------------------------
// -----------------------------------------------------------------------------
// This file defines the core data structure for a "Movement Family" as specified
// in the DXG document. It is designed to be parsed directly from the
// `movement_families.seed.json` file.
//
// The `@freezed` annotation is used to generate boilerplate code for creating an
// immutable data class, including `copyWith`, `==`, `hashCode`, and `toString`
// methods, as well as the `fromJson` factory.
// -----------------------------------------------------------------------------

@freezed
class MovementFamily with _$MovementFamily {
  const factory MovementFamily({
    required String id,
    required String name,
    required MovementPattern pattern,
    required List<String> primary_muscles,
    required List<String> secondary_muscles,
    required AllowedDiscriminators allowed,
    @Default([]) List<DenyRule> denies,
    required String display_name_template,
    @Default([]) List<NamingRule> naming_rules,
    @Default([]) List<String> aliases,
    String? notes,
  }) = _MovementFamily;

  factory MovementFamily.fromJson(Map<String, dynamic> json) =>
      _$MovementFamilyFromJson(json);
}

/// Represents the "allowed" block within a MovementFamily.
/// This defines the valid discriminator options for constructing an exercise.
@freezed
class AllowedDiscriminators with _$AllowedDiscriminators {
  const factory AllowedDiscriminators({
    @Default([]) List<String> equipment,
    @Default([]) List<String> angle,
    @Default([]) List<String> unilateral,
    @Default([]) List<String> orientation,
    @Default([]) List<String> attachment,
    // --- NEW ---
    // Added cable_height to support the new discriminator.
    @Default([]) List<String> cable_height,
    @Default([]) List<String> grip,
  }) = _AllowedDiscriminators;

  factory AllowedDiscriminators.fromJson(Map<String, dynamic> json) =>
      _$AllowedDiscriminatorsFromJson(json);
}

/// Represents a single "denies" rule.
/// This is used to explicitly forbid combinations that would otherwise be
/// allowed (e.g., denying a "rope" attachment for a "barbell").
@freezed
class DenyRule with _$DenyRule {
  const factory DenyRule({
    String? equipment,
    List<String>? attachment,
    // Add other discriminator fields here if more complex deny rules are needed.
  }) = _DenyRule;

  factory DenyRule.fromJson(Map<String, dynamic> json) =>
      _$DenyRuleFromJson(json);
}

/// Represents a "naming_rules" override.
/// This allows for specific combinations to generate a different display name
/// than the one from the main template (e.g., making a supinated pull-up
/// display as "Chin-Up").
@freezed
class NamingRule with _$NamingRule {
  const factory NamingRule({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'if') required Map<String, String> ifCondition,
    required String name,
  }) = _NamingRule;

  factory NamingRule.fromJson(Map<String, dynamic> json) =>
      _$NamingRuleFromJson(json);
}