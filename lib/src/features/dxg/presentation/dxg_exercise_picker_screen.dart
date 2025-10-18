// lib/src/features/dxg/presentation/dxg_exercise_picker_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';

// -----------------------------------------------------------------------------
// --- DXG EXERCISE PICKER SCREEN WIDGET ---------------------------------------
// -----------------------------------------------------------------------------
// This screen implements the chip-based UI for the Deterministic Exercise Graph.
// It allows users to progressively build a canonical exercise by selecting
// a family and then applying valid discriminator filters.
// -----------------------------------------------------------------------------

class DXGExercisePickerScreen extends ConsumerWidget {
  const DXGExercisePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state provider. The UI will rebuild whenever the state changes.
    final asyncDxgState = ref.watch(dxgStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exercise (New)'),
        backgroundColor: AppTheme.colors.surface,
      ),
      // --- UI FIX ---
      // The entire body is now wrapped in a SafeArea widget. This automatically
      // handles insets for system UI like the navigation bar, ensuring that
      // the ListView and its content are never obscured.
      body: SafeArea(
        child: asyncDxgState.when(
          // --- LOADING STATE ---
          loading: () => const Center(child: CircularProgressIndicator()),
          // --- ERROR STATE ---
          error: (err, stack) => Center(child: Text('Error: $err')),
          // --- DATA LOADED STATE ---
          data: (dxgState) {
            return ListView(
              // The manual bottom padding is no longer needed, as SafeArea handles it.
              // We keep the other padding for aesthetic spacing.
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              children: [
                // --- 1. FAMILY SELECTION ---
                _buildSectionHeader('Family'),
                _buildFamilyChips(ref, dxgState),
                const SizedBox(height: 24),

                // --- 2. DISCRIMINATOR SELECTIONS (Progressive) ---
                _buildDiscriminatorChips(ref, 'Equipment', 'equipment', dxgState),
                _buildDiscriminatorChips(ref, 'Angle / Line', 'angle', dxgState),
                _buildDiscriminatorChips(ref, 'Unilateral', 'unilateral', dxgState),
                _buildDiscriminatorChips(ref, 'Orientation', 'orientation', dxgState),
                _buildDiscriminatorChips(ref, 'Attachment', 'attachment', dxgState),
                _buildDiscriminatorChips(ref, 'Grip', 'grip', dxgState),

                // --- 3. RESULT CARD ---
                if (dxgState.canonicalExercise != null)
                  _buildResultCard(context, dxgState.canonicalExercise!),
              ],
            );
          },
        ),
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

    if (dxgState.selectedFamily == null || options == null || options.isEmpty || hasOnlyNoneOption) {
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
                ref.read(dxgStateProvider.notifier).updateSelection(field, newValue);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Builds the card that displays the final generated exercise.
  Widget _buildResultCard(BuildContext context, GeneratedExerciseResult result) {
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
              Navigator.of(context).pop(result);
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