// lib/src/features/dxg/presentation/dxg_exercise_picker_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';

// -----------------------------------------------------------------------------
// --- LOCAL STATE PROVIDER ----------------------------------------------------
// -----------------------------------------------------------------------------

/// An enum to manage the toggle state between Strength and Prep.
enum PickerMode { strength, prep }

/// A simple provider to hold the current mode of the picker UI.
final _pickerModeProvider = StateProvider.autoDispose<PickerMode>((ref) {
  return PickerMode.strength;
});

// -----------------------------------------------------------------------------
// --- DXG EXERCISE PICKER SCREEN WIDGET ---------------------------------------
// -----------------------------------------------------------------------------

class DXGExercisePickerScreen extends ConsumerWidget {
  const DXGExercisePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerMode = ref.watch(_pickerModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Session'),
        backgroundColor: AppTheme.colors.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<PickerMode>(
              segments: const [
                ButtonSegment(
                    value: PickerMode.strength,
                    label: Text('Strength'),
                    icon: Icon(Icons.fitness_center)),
                ButtonSegment(
                    value: PickerMode.prep,
                    label: Text('Prep'),
                    icon: Icon(Icons.self_improvement)),
              ],
              selected: {pickerMode},
              onSelectionChanged: (newSelection) {
                ref.read(_pickerModeProvider.notifier).state =
                    newSelection.first;
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child:
            pickerMode == PickerMode.strength ? _buildStrengthView(ref) : _buildPrepView(ref),
      ),
    );
  }

  /// Builds the main view for selecting strength exercises using the DXG engine.
  Widget _buildStrengthView(WidgetRef ref) {
    final asyncDxgState = ref.watch(dxgStateProvider);

    return asyncDxgState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (dxgState) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          children: [
            _buildSectionHeader('Family'),
            _buildFamilyChips(ref, dxgState),
            const SizedBox(height: 24),
            _buildDiscriminatorChips(ref, 'Equipment', 'equipment', dxgState),
            _buildDiscriminatorChips(ref, 'Angle / Line', 'angle', dxgState),
            _buildDiscriminatorChips(ref, 'Unilateral', 'unilateral', dxgState),
            _buildDiscriminatorChips(ref, 'Orientation', 'orientation', dxgState),
            _buildDiscriminatorChips(ref, 'Attachment', 'attachment', dxgState),
            _buildDiscriminatorChips(ref, 'Grip', 'grip', dxgState),
            if (dxgState.canonicalExercise != null)
              _buildResultCard(dxgState.canonicalExercise!),
          ],
        );
      },
    );
  }

  /// Builds the view for selecting warm-up/prep items from a simple list.
  Widget _buildPrepView(WidgetRef ref) {
    return const Center(
      child: Text(
        'Warm-up / Prep View (Coming Soon)',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  /// Builds the header text for a chip section.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: AppTheme.typography.title.copyWith(fontSize: 18),
      ),
    );
  }

  /// Builds the horizontal list of chips for selecting a Movement Family.
  Widget _buildFamilyChips(WidgetRef ref, DXGState dxgState) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: dxgState.allFamilies.map((family) {
        return FilterChip(
          label: Text(family.name),
          selected: dxgState.selectedFamilyId == family.id,
          onSelected: (_) {
            ref.read(dxgStateProvider.notifier).selectFamily(family.id);
          },
        );
      }).toList(),
    );
  }

  /// A generic builder for a row of discriminator chips (Equipment, Angle, etc.).
  Widget _buildDiscriminatorChips(
    WidgetRef ref,
    String title,
    String field,
    DXGState dxgState,
  ) {
    final options = dxgState.availableOptions[field];
    final bool hasOnlyNoneOption = (options?.length == 1 && options?.first == 'none');

    if (dxgState.selectedFamily == null ||
        options == null ||
        options.isEmpty ||
        hasOnlyNoneOption) {
      return const SizedBox.shrink();
    }

    final selectedValue = dxgState.selections[field];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: selectedValue == option,
              onSelected: (isSelected) {
                final newValue = isSelected ? option : null;
                ref
                    .read(dxgStateProvider.notifier)
                    .updateSelection(field, newValue);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Builds the card that displays the final generated exercise.
  Widget _buildResultCard(GeneratedExerciseResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Result'),
        Card(
          color: AppTheme.colors.surfaceAlt,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
            side: BorderSide(color: AppTheme.colors.accent, width: 2),
          ),
          child: InkWell(
            onTap: () {
              // This needs to be updated to handle returning a WarmupItem as well
            },
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      result.displayName,
                      style: AppTheme.typography.title,
                    ),
                  ),
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: AppTheme.colors.accent,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}