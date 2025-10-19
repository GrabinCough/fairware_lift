// ----- lib/src/features/dxg/application/dxg_state.dart -----
// lib/src/features/dxg/application/dxg_state.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';
import 'package:fairware_lift/src/features/dxg/domain/movement_family.dart';
import 'package:fairware_lift/src/features/dxg/application/guardrail_service.dart';
import 'package:fairware_lift/src/features/dxg/application/name_slug_service.dart';

part 'dxg_state.freezed.dart';

// -----------------------------------------------------------------------------
// --- HELPER DATA CLASSES -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A simple data class to hold the result of a generated exercise.
@freezed
class GeneratedExerciseResult with _$GeneratedExerciseResult {
  const factory GeneratedExerciseResult({
    required String displayName,
    required String slug,
    required SelectionsMap discriminators,
    required String familyId,
  }) = _GeneratedExerciseResult;
}

/// The immutable state object for the DXG exercise picker.
@freezed
class DXGState with _$DXGState {
  const DXGState._();

  const factory DXGState({
    /// The master list of all families, loaded once from the seed JSON.
    required List<MovementFamily> allFamilies,

    /// The user's currently selected family ID.
    String? selectedFamilyId,

    /// The user's currently selected discriminator values.
    @Default({}) SelectionsMap selections,

    /// The calculated set of valid options for each discriminator field.
    @Default({}) CandidateOptions availableOptions,

    /// The final, generated canonical exercise if all required fields are selected.
    GeneratedExerciseResult? canonicalExercise,
  }) = _DXGState;

  /// A computed property to easily access the full MovementFamily object.
  MovementFamily? get selectedFamily => allFamilies
      .firstWhereOrNull((family) => family.id == selectedFamilyId);
}

// -----------------------------------------------------------------------------
// --- STATE NOTIFIER ----------------------------------------------------------
// -----------------------------------------------------------------------------

class DXGStateNotifier extends AutoDisposeAsyncNotifier<DXGState> {
  @override
  Future<DXGState> build() async {
    // This method is called once to provide the initial state.
    // We load the seed data from the JSON asset here.
    final families = await _loadMovementFamilies();
    return DXGState(allFamilies: families);
  }

  /// Loads and parses the `movement_families.seed.json` file from assets.
  Future<List<MovementFamily>> _loadMovementFamilies() async {
    final jsonString =
        await rootBundle.loadString('assets/dxg/movement_families.seed.json');
    final jsonResponse = json.decode(jsonString) as Map<String, dynamic>;
    final familiesList = jsonResponse['movement_families'] as List;
    return familiesList
        .map((familyJson) =>
            MovementFamily.fromJson(familyJson as Map<String, dynamic>))
        .toList();
  }

  /// Updates the state when the user selects a movement family.
  void selectFamily(String familyId) {
    final currentState = state.value;
    if (currentState == null) return;

    final newFamily = currentState.allFamilies
        .firstWhereOrNull((f) => f.id == familyId);
    if (newFamily == null) return;

    // When a new family is selected, reset all discriminator selections.
    final newSelections = <String, String>{};
    state = AsyncData(_recalculateState(
      currentState.copyWith(
        selectedFamilyId: familyId,
        selections: newSelections,
      ),
    ));
  }

  /// Updates the state when the user selects or deselects a discriminator value.
  void updateSelection(String field, String? value) {
    final currentState = state.value;
    if (currentState == null || currentState.selectedFamily == null) return;

    final newSelections = Map<String, String>.from(currentState.selections);
    if (value == null) {
      // If value is null, deselect this discriminator.
      newSelections.remove(field);
    } else {
      // Otherwise, update the selection.
      newSelections[field] = value;
    }

    state = AsyncData(_recalculateState(
      currentState.copyWith(selections: newSelections),
    ));
  }

  /// A central method to recalculate all derived state.
  DXGState _recalculateState(DXGState newState) {
    final guardrailService = ref.read(guardrailServiceProvider);
    final nameSlugService = ref.read(nameAndSlugServiceProvider);

    final family = newState.selectedFamily;
    if (family == null) {
      // If no family is selected, there are no options or results.
      return newState.copyWith(
        availableOptions: {},
        canonicalExercise: null,
      );
    }

    // 1. Calculate the currently available options using the GuardrailService.
    final availableOptions = guardrailService.getCandidateOptions(
      family: family,
      selections: newState.selections,
    );

    // --- BUG FIX ---
    // The logic to determine if a canonical exercise can be generated is now
    // more robust. Instead of relying on the display template, it checks if
    // a selection has been made for every available (i.e., visible)
    // discriminator category.
    bool hasAllRequiredFields = true;
    for (final entry in availableOptions.entries) {
      final field = entry.key;
      final options = entry.value;

      // A field is considered required if it has options available to choose from.
      // We ignore fields that only contain 'none'.
      final bool isEffectivelyEmpty = options.isEmpty || (options.length == 1 && options.first == 'none');

      if (!isEffectivelyEmpty && !newState.selections.containsKey(field)) {
        hasAllRequiredFields = false;
        break;
      }
    }

    GeneratedExerciseResult? canonicalExercise;
    if (hasAllRequiredFields) {
      // 3. If so, generate the name and slug using the NameAndSlugService.
      final displayName = nameSlugService.toDisplayName(
        family: family,
        discriminators: newState.selections,
      );
      final slug = nameSlugService.toSlug(
        familyId: family.id,
        discriminators: newState.selections,
      );
      canonicalExercise = GeneratedExerciseResult(
        displayName: displayName,
        slug: slug,
        discriminators: newState.selections,
        familyId: family.id,
      );
    }

    return newState.copyWith(
      availableOptions: availableOptions,
      canonicalExercise: canonicalExercise,
    );
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

// The provider is an `AutoDisposeAsyncNotifierProvider`. This ensures that
// when the exercise picker screen is closed (and no longer being listened to),
// the state is automatically destroyed. The next time the user opens the
// picker, a fresh instance of the notifier will be created.
final dxgStateProvider =
    AutoDisposeAsyncNotifierProvider<DXGStateNotifier, DXGState>(
        DXGStateNotifier.new);