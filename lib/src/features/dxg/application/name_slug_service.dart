// lib/src/features/dxg/application/name_slug_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/dxg/domain/movement_family.dart';
import 'package:fairware_lift/src/features/dxg/application/guardrail_service.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart'; // To access allFamilies

// -----------------------------------------------------------------------------
// --- NAME & SLUG SERVICE -----------------------------------------------------
// -----------------------------------------------------------------------------

class NameAndSlugService {
  // --- NEW ---
  // The service now requires a reference to the list of movement families.
  final List<MovementFamily> _families;
  NameAndSlugService(this._families);

  /// --- NEW METHOD ---
  /// Finds a movement family by its name or one of its aliases.
  /// This is the core of the "hybrid normalization" step.
  MovementFamily? findFamilyByNameOrAlias(String name) {
    final lowerCaseName = name.toLowerCase();
    for (final family in _families) {
      if (family.name.toLowerCase() == lowerCaseName) {
        return family;
      }
      for (final alias in family.aliases) {
        if (alias.toLowerCase() == lowerCaseName) {
          return family;
        }
      }
    }
    return null; // Return null if no match is found
  }

  String toSlug({
    required String familyId,
    required SelectionsMap discriminators,
  }) {
    const fieldsInOrder = [
      'equipment',
      'angle',
      'unilateral',
      'orientation',
      'attachment',
      'cable_height',
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

  String toDisplayName({
    required MovementFamily family,
    required SelectionsMap discriminators,
  }) {
    String template = family.display_name_template;
    for (final rule in family.naming_rules) {
      if (_doesRuleApply(rule.ifCondition, discriminators)) {
        template = rule.name;
        break;
      }
    }

    String result =
        template.replaceAll('{{familyName}}', family.name.split(' ')[0]);

    final tokenRegex = RegExp(r'\{\{(\w+)(\??)(_paren\??)?\}\}');
    result = result.replaceAllMapped(tokenRegex, (match) {
      final field = match.group(1)!;
      final isParenthesized = match.group(3) != null;
      final value = discriminators[field];

      if (value != null) {
        final humanized = _humanize(field, value);
        return isParenthesized ? ' ($humanized)' : humanized;
      }
      return '';
    });

    if (family.id == 'row' || family.id == 'fly') {
      if (discriminators['unilateral'] == 'unilateral') {
        result += ', 1-Arm';
      }
    }

    return result.replaceAll(RegExp(r'\\s+'), ' ').trim();
  }

  bool _doesRuleApply(Map<String, String> condition, SelectionsMap selections) {
    return condition.entries.every((entry) {
      return selections[entry.key] == entry.value;
    });
  }

  String _humanize(String field, String value) {
    if (field == 'cable_height') {
      return 'Pos: $value';
    }

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
      'hip_hinge_setup': 'Bent-Over',
    };

    if (humanizationMap.containsKey(value)) {
      return humanizationMap[value]!;
    }

    final words = value.split('_');
    return words.map((w) => '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final nameAndSlugServiceProvider = Provider<NameAndSlugService>((ref) {
  // The provider now depends on the dxgStateProvider to get the list of families.
  // This ensures that the service is always initialized with the necessary data.
  final families = ref.watch(dxgStateProvider).value?.allFamilies ?? [];
  return NameAndSlugService(families);
});