// lib/src/features/workout/presentation/widgets/timed_set_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- TIMED SET SHEET WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful bottom sheet for entering the details of a timed set.
class TimedSetSheet extends StatefulWidget {
  const TimedSetSheet({super.key});

  @override
  State<TimedSetSheet> createState() => _TimedSetSheetState();
}

class _TimedSetSheetState extends State<TimedSetSheet> {
  final _durationMinutesController = TextEditingController();
  final _durationSecondsController = TextEditingController();
  final _inclineController = TextEditingController();
  final _speedController = TextEditingController();

  @override
  void dispose() {
    _durationMinutesController.dispose();
    _durationSecondsController.dispose();
    _inclineController.dispose();
    _speedController.dispose();
    super.dispose();
  }

  void _onLogSet() {
    final minutes = int.tryParse(_durationMinutesController.text) ?? 0;
    final seconds = int.tryParse(_durationSecondsController.text) ?? 0;
    final totalDurationSeconds = (minutes * 60) + seconds;

    final incline = double.tryParse(_inclineController.text);
    final speed = double.tryParse(_speedController.text);

    final metrics = <String, dynamic>{};
    if (incline != null) {
      metrics['incline'] = incline;
    }
    if (speed != null) {
      metrics['speed_mph'] = speed;
    }

    if (mounted) {
      Navigator.of(context).pop({
        'durationSeconds': totalDurationSeconds,
        'metrics': metrics,
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
                    controller: _durationMinutesController,
                    label: 'Minutes',
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _durationSecondsController,
                    label: 'Seconds',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _inclineController,
                    label: 'Incline (%)',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _speedController,
                    label: 'Speed (mph)',
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