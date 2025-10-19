// ----- lib/src/features/dxg/application/guardrail_service.dart -----
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
  CandidateOptions getCandidateOptions({
    required MovementFamily family,
    required SelectionsMap selections,
  }) {
    final allowed = family.allowed;
    final denials = family.denies;

    // Helper to compute candidates for a single field, considering denials.
    Set<String> _getOptionsForField(
      List<String> allowedValues,
      String currentField,
    ) {
      final options = Set<String>.from(allowedValues);
      final denialsToRemove = <String>{};

      for (final rule in denials) {
        bool ruleMatches = true;
        if (rule.equipment != null &&
            selections['equipment'] != rule.equipment) {
          ruleMatches = false;
        }

        if (ruleMatches) {
          if (currentField == 'attachment' && rule.attachment != null) {
            denialsToRemove.addAll(rule.attachment!);
          }
        }
      }
      options.removeAll(denialsToRemove);
      return options;
    }

    // Attachments are only relevant for cable exercises. This logic now
    // checks the selected equipment. If it's not 'cable', the attachment
    // options will be an empty set, preventing the UI from showing the section.
    final attachmentOptions = (selections['equipment'] == 'cable')
        ? _getOptionsForField(allowed.attachment, 'attachment')
        : <String>{};

    // --- NEW ---
    // Cable height is only relevant for cable exercises.
    final cableHeightOptions = (selections['equipment'] == 'cable')
        ? Set<String>.from(allowed.cable_height)
        : <String>{};

    return {
      'equipment': Set<String>.from(allowed.equipment),
      'angle': Set<String>.from(allowed.angle),
      'unilateral': Set<String>.from(allowed.unilateral),
      'orientation': Set<String>.from(allowed.orientation),
      'attachment': attachmentOptions,
      'cable_height': cableHeightOptions,
      'grip': Set<String>.from(allowed.grip),
    };
  }

  /// Validates the user's complete set of selections against the family's rules.
  ValidationResult validateSelection({
    required MovementFamily family,
    required SelectionsMap selections,
  }) {
    final candidates = getCandidateOptions(family: family, selections: selections);

    for (final entry in selections.entries) {
      final field = entry.key;
      final selectedValue = entry.value;
      final validOptions = candidates[field];

      if (validOptions == null || !validOptions.contains(selectedValue)) {
        return (
          isValid: false,
          reason:
              "'$selectedValue' is not a valid option for '$field' with the current selections."
        );
      }
    }
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