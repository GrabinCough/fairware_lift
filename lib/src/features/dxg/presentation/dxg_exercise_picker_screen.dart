// ----- lib/src/features/dxg/presentation/dxg_exercise_picker_screen.dart -----
// lib/src/features/dxg/presentation/dxg_exercise_picker_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/dxg/application/dxg_state.dart';
import 'package:fairware_lift/src/features/dxg/application/warmup_service.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';

// -----------------------------------------------------------------------------
// --- LOCAL STATE PROVIDER ----------------------------------------------------
// -----------------------------------------------------------------------------

enum PickerMode { strength, prep }

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
      // --- BUG FIX ---
      // The body is now wrapped in a `switch` expression that correctly returns
      // the view based on the picker mode. This ensures the `_buildPrepView` is
      // always rendered when the "Prep" mode is selected.
      body: SafeArea(
        child: switch (pickerMode) {
          PickerMode.strength => _buildStrengthView(context, ref),
          PickerMode.prep => _buildPrepView(context, ref),
        },
      ),
    );
  }

  Widget _buildStrengthView(BuildContext context, WidgetRef ref) {
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
            _buildDiscriminatorChips(ref, 'Cable Height', 'cable_height', dxgState),
            _buildDiscriminatorChips(ref, 'Grip', 'grip', dxgState),
            if (dxgState.canonicalExercise != null)
              _buildResultCard(context, dxgState.canonicalExercise!),
          ],
        );
      },
    );
  }

  Widget _buildPrepView(BuildContext context, WidgetRef ref) {
    final warmupItemsAsync = ref.watch(warmupItemsProvider);
    return warmupItemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (items) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.displayName),
              subtitle: Text('${item.region} - ${item.modality}'),
              onTap: () async {
                if (item.parameters.isNotEmpty) {
                  final selectedParameters = await _showParameterDialog(context, item);
                  if (selectedParameters != null) {
                    Navigator.of(context).pop({'item': item, 'params': selectedParameters});
                  }
                } else {
                  Navigator.of(context).pop({'item': item, 'params': <String, String>{}});
                }
              },
            );
          },
        );
      },
    );
  }

  Future<Map<String, String>?> _showParameterDialog(
      BuildContext context, WarmupItem item) {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        final selections = <String, String>{};
        for (var p in item.parameters) {
          if (p.options.isNotEmpty) {
            selections[p.name] = p.options.first;
          }
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppTheme.colors.surface,
              title: Text(item.displayName),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: item.parameters.map((param) {
                    return DropdownButtonFormField<String>(
                      value: selections[param.name],
                      items: param.options.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selections[param.name] = value);
                        }
                      },
                      decoration: InputDecoration(labelText: param.name),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(selections);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: AppTheme.typography.title.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _buildFamilyChips(WidgetRef ref, DXGState dxgState) {
    final sortedFamilies = List.from(dxgState.allFamilies)
      ..sort((a, b) => a.name.compareTo(b.name));

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: sortedFamilies.map((family) {
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

  Widget _buildResultCard(
      BuildContext context, GeneratedExerciseResult result) {
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