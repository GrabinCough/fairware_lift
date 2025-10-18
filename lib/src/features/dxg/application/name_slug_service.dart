// lib/src/features/dxg/application/name_slug_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/dxg/domain/movement_family.dart';
import 'package:fairware_lift/src/features/dxg/application/guardrail_service.dart';

// -----------------------------------------------------------------------------
// --- NAME & SLUG SERVICE -----------------------------------------------------
// -----------------------------------------------------------------------------
// This service implements the "DisplayName + Slug helpers" from the DXG spec.
// It is responsible for taking a movement family and a validated map of
// discriminators and generating the deterministic, canonical outputs.
// -----------------------------------------------------------------------------

class NameAndSlugService {
  /// Generates a stable, unique slug from a family ID and selections.
  ///
  /// As per DXG spec §5, the slug is a dot-separated string of the family ID
  /// and the values of the discriminators in a fixed, canonical order.
  String toSlug({
    required String familyId,
    required SelectionsMap discriminators,
  }) {
    // The canonical order for all fields that can be part of a slug.
    const fieldsInOrder = [
      'equipment',
      'angle',
      'unilateral',
      'orientation',
      'attachment',
      'grip',
    ];

    final slugParts = [familyId];
    for (final field in fieldsInOrder) {
      if (discriminators.containsKey(field)) {
        slugParts.add(discriminators[field]!);
      }
    }

    return slugParts.join('.');
  }

  /// Generates a human-readable display name from a family and selections.
  ///
  /// This method performs three main steps:
  /// 1. Determines the correct template to use (checking for naming rule overrides).
  /// 2. Processes the template by replacing tokens with humanized values.
  /// 3. Applies final post-processing and special case formatting.
  String toDisplayName({
    required MovementFamily family,
    required SelectionsMap discriminators,
  }) {
    // --- Step 1: Find the correct template ---
    String template = family.display_name_template;
    for (final rule in family.naming_rules) {
      if (_doesRuleApply(rule.ifCondition, discriminators)) {
        template = rule.name;
        break; // Use the first matching rule
      }
    }

    // --- Step 2: Process the template ---
    // Replace `{{familyName}}` token first.
    String result = template.replaceAll('{{familyName}}', family.name.split(' ')[0]);

    // Regex to find all {{...}} tokens.
    final tokenRegex = RegExp(r'\{\{(\w+)(\??)(_paren\??)?\}\}');
    result = result.replaceAllMapped(tokenRegex, (match) {
      final field = match.group(1)!;
      final isParenthesized = match.group(3) != null;
      final value = discriminators[field];

      if (value != null) {
        final humanized = _humanize(field, value);
        return isParenthesized ? ' ($humanized)' : humanized;
      }
      return ''; // If discriminator is not present, remove the token.
    });

    // --- Step 3: Post-processing and special cases ---
    // Handle the ", 1-Arm" suffix for unilateral rows, as seen in test cases.
    if (family.id == 'row' || family.id == 'fly') {
      if (discriminators['unilateral'] == 'unilateral') {
        result += ', 1-Arm';
      }
    }
    
    // Clean up any extra whitespace from removed tokens.
    return result.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Checks if a naming rule's `if` condition is met by the current selections.
  bool _doesRuleApply(Map<String, String> condition, SelectionsMap selections) {
    return condition.entries.every((entry) {
      return selections[entry.key] == entry.value;
    });
  }

  /// Converts a discriminator slug value into a human-friendly, title-cased string.
  String _humanize(String field, String value) {
    // A simple humanization map. This could be expanded or moved to a config file.
    const humanizationMap = {
      'ez_bar': 'EZ Bar',
      'v_bar': 'V-Bar',
      'd_handle': 'D-Handle',
      'lat_bar': 'Lat Bar',
      'single_d_handle': 'Single D-Handle',
      'straight_bar': 'Straight Bar',
      'seated_cable': 'Seated Cable',
      'incline_bench': 'Incline Bench',
      'bulgarian_split': 'Bulgarian Split',
      'trapbar': 'Trap Bar',
    };

    if (humanizationMap.containsKey(value)) {
      return humanizationMap[value]!;
    }
    
    // Default behavior: replace underscores and title case.
    final words = value.split('_');
    return words.map((w) => '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A Riverpod provider to make a singleton instance of the NameAndSlugService
/// available to the rest of the application.
final nameAndSlugServiceProvider = Provider<NameAndSlugService>((ref) {
  return NameAndSlugService();
});