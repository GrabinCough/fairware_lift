// lib/src/features/workout/presentation/widgets/duration_picker_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- DURATION PICKER SHEET WIDGET --------------------------------------------
// -----------------------------------------------------------------------------

/// A custom bottom sheet for selecting a duration using flat, scrollable lists.
class DurationPickerSheet extends StatefulWidget {
  final Duration initialDuration;

  const DurationPickerSheet({
    super.key,
    this.initialDuration = const Duration(minutes: 1, seconds: 30),
  });

  @override
  State<DurationPickerSheet> createState() => _DurationPickerSheetState();
}

class _DurationPickerSheetState extends State<DurationPickerSheet> {
  late int _selectedMinutes;
  late int _selectedSeconds;

  @override
  void initState() {
    super.initState();
    _selectedMinutes = widget.initialDuration.inMinutes;
    _selectedSeconds = widget.initialDuration.inSeconds % 60;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            // --- PICKER UI ---
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- MINUTES PICKER ---
                  _buildPicker(
                    itemCount: 60, // 0-59 minutes
                    initialItem: _selectedMinutes,
                    suffix: ' min',
                    onChanged: (value) {
                      setState(() {
                        _selectedMinutes = value;
                      });
                    },
                  ),
                  // --- SECONDS PICKER ---
                  _buildPicker(
                    itemCount: 60, // 0-59 seconds
                    initialItem: _selectedSeconds,
                    suffix: ' sec',
                    onChanged: (value) {
                      setState(() {
                        _selectedSeconds = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            // --- CONFIRMATION BUTTON ---
            TextButton(
              child: Text(
                'Start Rest',
                style: AppTheme.typography.body.copyWith(
                  color: AppTheme.colors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                final totalDuration =
                    Duration(minutes: _selectedMinutes, seconds: _selectedSeconds);
                // Return the selected duration to the calling widget.
                Navigator.of(context).pop(totalDuration);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Helper method to build a single scrollable list for minutes or seconds.
  Widget _buildPicker({
    required int itemCount,
    required int initialItem,
    required String suffix,
    required ValueChanged<int> onChanged,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        // These properties create the flat look instead of a 3D cylinder.
        magnification: 1.0,
        useMagnifier: false,
        // This removes the 3D perspective effect.
        offAxisFraction: 0.0,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: initialItem),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                '$index$suffix',
                style: AppTheme.typography.title.copyWith(fontSize: 20),
              ),
            );
          },
          childCount: itemCount,
        ),
      ),
    );
  }
}