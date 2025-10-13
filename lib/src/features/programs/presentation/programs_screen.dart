// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// --- PROGRAMS SCREEN WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// A placeholder widget for the "Programs" screen.
///
/// This screen will allow users to create, view, and manage their workout
/// programs, as defined in the Information Architecture (SSOT §3).
///
/// For now, it simply displays a centered text label to indicate its presence
/// in the UI.
class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for a material
    // design screen.
    return const Scaffold(
      // The body is centered to hold the placeholder text.
      body: Center(
        child: Text('Programs Screen'),
      ),
    );
  }
}