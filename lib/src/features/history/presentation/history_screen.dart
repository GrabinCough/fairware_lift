// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// --- HISTORY SCREEN WIDGET ---------------------------------------------------
// -----------------------------------------------------------------------------

/// A placeholder widget for the "History" screen.
///
/// This screen will display a log of all past workouts, allowing users to
/// review their performance and progress over time, as defined in the
/// Information Architecture (SSOT §3).
///
/// For now, it simply displays a centered text label to indicate its presence
/// in the UI.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for a material
    // design screen.
    return const Scaffold(
      // The body is centered to hold the placeholder text.
      body: Center(
        child: Text('History Screen'),
      ),
    );
  }
}