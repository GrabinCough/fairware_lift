// lib/src/features/workout/presentation/widgets/set_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- SET SHEET WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful bottom sheet for entering the details of a single set.
class SetSheet extends StatefulWidget {
  // --- FIX ---
  // The constructor no longer accepts initial values.
  const SetSheet({super.key});

  @override
  State<SetSheet> createState() => _SetSheetState();
}

class _SetSheetState extends State<SetSheet> {
  // Controllers are initialized directly.
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();

  // --- FIX ---
  // The initState method is no longer needed as the controllers are
  // initialized directly and will always start blank.

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _onLogSet() {
    final weight = double.tryParse(_weightController.text) ?? 0.0;
    final reps = int.tryParse(_repsController.text) ?? 0;

    if (mounted) {
      Navigator.of(context).pop({'weight': weight, 'reps': reps});
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
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _weightController,
                    label: 'Weight (lb)',
                    // Autofocus the first field for quick entry.
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _repsController,
                    label: 'Reps',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onLogSet,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save & Start Rest'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool autofocus = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      style: AppTheme.typography.number,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.typography.body,
        filled: true,
        fillColor: AppTheme.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}