 // lib/src/features/prompt_studio/presentation/sheets/coach_switchboard_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- COACH SWITCHBOARD SHEET WIDGET ------------------------------------------
// -----------------------------------------------------------------------------

/// A bottom sheet for the "Coach Switchboard" prompt builder.
///
/// This widget will display the auto-summary and generate the re-onboarding prompt.
/// This is the initial scaffold.
class CoachSwitchboardSheet extends StatelessWidget {
  const CoachSwitchboardSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Switching Coaches 🔄'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Coach Switchboard UI Goes Here',
          style: AppTheme.typography.title,
        ),
      ),
    );
  }
}