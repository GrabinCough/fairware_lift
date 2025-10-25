// ----- lib/src/features/workout/presentation/widgets/set_sheet.dart -----
// lib/src/features/workout/presentation/widgets/set_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/workout/domain/logged_set.dart';

// -----------------------------------------------------------------------------
// --- SET SHEET WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful bottom sheet for entering or editing the details of a single set.
class SetSheet extends StatefulWidget {
  // --- NEW: Accept an optional set to edit ---
  final LoggedSet? set;

  const SetSheet({super.key, this.set});

  @override
  State<SetSheet> createState() => _SetSheetState();
}

class _SetSheetState extends State<SetSheet> {
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();

  // --- NEW: Pre-fill controllers if editing an existing set ---
  @override
  void initState() {
    super.initState();
    if (widget.set != null) {
      _weightController.text = widget.set!.weight?.toString() ?? '';
      _repsController.text = widget.set!.reps?.toString() ?? '';
    }
  }

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
      // --- MODIFIED: Return the set's ID if it exists (for updates) ---
      Navigator.of(context).pop({
        'id': widget.set?.id,
        'weight': weight,
        'reps': reps,
      });
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
              // --- MODIFIED: More generic button text ---
              child: const Text('Save Set'),
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