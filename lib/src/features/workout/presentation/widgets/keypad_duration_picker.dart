// lib/src/features/workout/presentation/widgets/keypad_duration_picker.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- KEYPAD DURATION PICKER WIDGET -------------------------------------------
// -----------------------------------------------------------------------------

/// A custom bottom sheet for selecting a duration using a keypad interface.
/// This version treats the input as total seconds.
class KeypadDurationPicker extends StatefulWidget {
  const KeypadDurationPicker({super.key});

  @override
  State<KeypadDurationPicker> createState() => _KeypadDurationPickerState();
}

class _KeypadDurationPickerState extends State<KeypadDurationPicker> {
  // Stores the raw digits entered by the user, e.g., "90" for 90 seconds.
  String _input = '';

  /// --- UI/LOGIC FIX ---
  /// Handles when a number button is pressed. Input is now limited to 3 digits.
  void _onDigitPress(int digit) {
    if (_input.length < 3) {
      setState(() {
        _input += digit.toString();
      });
    }
  }

  /// Handles when the backspace button is pressed.
  void _onBackspacePress() {
    if (_input.isNotEmpty) {
      setState(() {
        _input = _input.substring(0, _input.length - 1);
      });
    }
  }

  /// --- UI/LOGIC FIX ---
  /// Formats the input as a simple seconds string, e.g., "90s".
  String _formatDisplayTime() {
    if (_input.isEmpty) {
      return "0s";
    }
    return '${_input}s';
  }

  /// --- UI/LOGIC FIX ---
  /// Parses the input string directly into seconds.
  Duration _parseDuration() {
    if (_input.isEmpty) return Duration.zero;
    final totalSeconds = int.tryParse(_input) ?? 0;
    return Duration(seconds: totalSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 480,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- TIME DISPLAY ---
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  _formatDisplayTime(),
                  style: AppTheme.typography.display.copyWith(
                    fontSize: 64,
                    color: _input.isEmpty
                        ? AppTheme.colors.textMuted
                        : AppTheme.colors.textPrimary,
                  ),
                ),
              ),
            ),
            // --- KEYPAD GRID ---
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildKeypadButton('7'),
                _buildKeypadButton('8'),
                _buildKeypadButton('9'),
                _buildKeypadButton('4'),
                _buildKeypadButton('5'),
                _buildKeypadButton('6'),
                _buildKeypadButton('1'),
                _buildKeypadButton('2'),
                _buildKeypadButton('3'),
                const SizedBox.shrink(),
                _buildKeypadButton('0'),
                _buildKeypadButton(
                  '⌫',
                  onTap: _onBackspacePress,
                  onLongPress: () => setState(() => _input = ''),
                ),
              ],
            ),
            const Spacer(),
            // --- START BUTTON ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _input.isNotEmpty
                    ? () => Navigator.of(context).pop(_parseDuration())
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Start Rest'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build a single button for the keypad.
  Widget _buildKeypadButton(
    String text, {
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return InkWell(
      onTap: onTap ?? () => _onDigitPress(int.parse(text)),
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(100),
      child: Center(
        child: Text(
          text,
          style: AppTheme.typography.title,
        ),
      ),
    );
  }
}