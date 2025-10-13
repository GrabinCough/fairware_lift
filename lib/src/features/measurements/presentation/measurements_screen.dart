// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// --- MEASUREMENTS SCREEN WIDGET ----------------------------------------------
// -----------------------------------------------------------------------------

/// A placeholder widget for the "Measurements" screen.
///
/// This screen will enable users to track various body measurements, view
/// progress charts, and manage photos, as defined in the Information
/// Architecture (SSOT §3).
///
/// For now, it simply displays a centered text label to indicate its presence
/// in the UI.
class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for a material
    // design screen.
    return const Scaffold(
      // The body is centered to hold the placeholder text.
      body: Center(
        child: Text('Measurements Screen'),
      ),
    );
  }
}