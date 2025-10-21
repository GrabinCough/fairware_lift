// lib/src/features/measurements/presentation/add_measurement_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/measurements/data/measurements_repository.dart';

// -----------------------------------------------------------------------------
// --- ADD MEASUREMENT SHEET WIDGET --------------------------------------------
// -----------------------------------------------------------------------------

class AddMeasurementSheet extends ConsumerStatefulWidget {
  const AddMeasurementSheet({super.key});

  @override
  ConsumerState<AddMeasurementSheet> createState() =>
      _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends ConsumerState<AddMeasurementSheet> {
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the text field with the current weight if it exists.
    final currentWeight = ref.read(latestBodyweightProvider);
    if (currentWeight != null) {
      _weightController.text = currentWeight.toString();
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _onSave() async {
    final weight = double.tryParse(_weightController.text);
    if (weight == null || weight <= 0) {
      // Optional: show a snackbar for invalid input
      return;
    }

    // Use the repository to save the data
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.saveLatestBodyweight(weight);

    // Update the state provider to trigger a UI rebuild
    ref.read(latestBodyweightProvider.notifier).state = weight;

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: AppTheme.typography.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Bodyweight (lbs)',
                labelStyle: AppTheme.typography.body,
                filled: true,
                fillColor: AppTheme.colors.surface,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppTheme.sizing.cardRadius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save Measurement'),
            ),
          ],
        ),
      ),
    );
  }
}