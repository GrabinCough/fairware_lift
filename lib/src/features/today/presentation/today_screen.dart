// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// --- TODAY SCREEN WIDGET -----------------------------------------------------
// -----------------------------------------------------------------------------

/// A placeholder widget for the "Today" screen.
///
/// This screen is the primary landing page for the user, as defined by the
/// Information Architecture in SSOT §3. It will eventually contain the
/// logic for starting a workout and viewing the day's activities.
///
/// For now, it simply displays a centered text label to indicate its presence
/// in the UI.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for a material
    // design screen.
    return const Scaffold(
      // The body is centered to hold the placeholder text.
      body: Center(
        child: Text('Today Screen'),
      ),
    );
  }
}