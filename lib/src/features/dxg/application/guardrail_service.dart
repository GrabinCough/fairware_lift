// lib/src/features/dxg/application/guardrail_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/dxg/domain/movement_family.dart';

// -----------------------------------------------------------------------------
// --- CONFIGURATION & DATA CLASSES --------------------------------------------
// -----------------------------------------------------------------------------

/// A simple record to hold the result of a validation check, as specified
/// in the DXG document.
typedef ValidationResult = ({bool isValid, String? reason});

/// A type alias for the map of currently selected discriminators.
/// e.g., {'equipment': 'dumbbell', 'angle': 'incline'}
typedef SelectionsMap = Map<String, String>;

/// A type alias for the result of getCandidateOptions. It maps a discriminator
/// field to a set of valid string options.
/// e.g., {'attachment': {'none', 'straight_bar', 'ez_bar'}}
typedef CandidateOptions = Map<String, Set<String>>;

// -----------------------------------------------------------------------------
// --- GUARDRAIL SERVICE -------------------------------------------------------
// -----------------------------------------------------------------------------
// This service implements the "Guardrail Engine" from the DXG specification.
// Its primary role is to determine the valid set of discriminator options
// based on a movement family's rules and the user's current selections.
// -----------------------------------------------------------------------------

class GuardrailService {
  /// Computes the available, valid options for all discriminator fields.
  ///
  /// This is the core of the Guardrail Engine. It takes a movement family and
  /// the user's current selections, and for each discriminator type (equipment,
  /// angle, etc.), it returns the set of choices that are still valid.
  ///
  /// Evaluation Order (from DXG spec 4):
  /// 1. Start with the full `allowed` list for a given field.
  /// 2. Subtract any values that are explicitly forbidden by a `denies` rule
  ///    that matches the *other* current selections.
  CandidateOptions getCandidateOptions({
    required MovementFamily family,
    required SelectionsMap selections,
  }) {
    final allowed = family.allowed;
    final denials = family.denies;

    // Helper function to compute candidates for a single field.
    Set<String> _getOptionsForField(
      List<String> allowedValues,
      String currentField,
    ) {
      final options = Set<String>.from(allowedValues);
      final denialsToRemove = <String>{};

      // Check each deny rule to see if it applies.
      for (final rule in denials) {
        // A rule applies if its conditions match the user's current selections.
        bool ruleMatches = true;
        if (rule.equipment != null &&
            selections['equipment'] != rule.equipment) {
          ruleMatches = false;
        }
        // Add checks for other fields (e.g., angle) if deny rules become more complex.

        if (ruleMatches) {
          // If the rule matches, find any denials for the field we are currently calculating.
          if (currentField == 'attachment' && rule.attachment != null) {
            denialsToRemove.addAll(rule.attachment!);
          }
          // Add other fields here as needed.
        }
      }

      options.removeAll(denialsToRemove);
      return options;
    }

    // Calculate the valid options for each discriminator field.
    return {
      'equipment': Set<String>.from(allowed.equipment), // Denials don't currently restrict equipment
      'angle': Set<String>.from(allowed.angle),
      'unilateral': Set<String>.from(allowed.unilateral),
      'orientation': Set<String>.from(allowed.orientation),
      'attachment': _getOptionsForField(allowed.attachment, 'attachment'),
      'grip': Set<String>.from(allowed.grip),
    };
  }

  /// Validates the user's complete set of selections against the family's rules.
  ValidationResult validateSelection({
    required MovementFamily family,
    required SelectionsMap selections,
  }) {
    final candidates = getCandidateOptions(family: family, selections: selections);

    // Check each of the user's selections.
    for (final entry in selections.entries) {
      final field = entry.key;
      final selectedValue = entry.value;
      final validOptions = candidates[field];

      if (validOptions == null || !validOptions.contains(selectedValue)) {
        // This selection is invalid.
        return (
          isValid: false,
          reason:
              "'$selectedValue' is not a valid option for '$field' with the current selections."
        );
      }
    }

    // If all selections are valid, the overall selection is valid.
    return (isValid: true, reason: null);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A Riverpod provider to make a singleton instance of the GuardrailService
/// available to the rest of the application.
final guardrailServiceProvider = Provider<GuardrailService>((ref) {
  return GuardrailService();
});