// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- MEASUREMENTS SCREEN WIDGET ----------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for tracking body measurements, progress photos, and charts.
///
/// This implementation shows the "Empty State" UI (SSOT 5.1) which is
/// displayed when the user has not yet added any measurements.
class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for the screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      // The body is centered to hold the empty state content.
      body: Center(
        child: Padding(
          // Horizontal padding to keep content from touching screen edges.
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.sizing.baseGrid * 4, // 32pt
          ),
          child: Column(
            // Center the content vertically.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- ILLUSTRATION PLACEHOLDER ---
              // A placeholder for a future illustration. An icon is used for now.
              Icon(
                Icons.monitor_weight_rounded,
                size: 80,
                color: AppTheme.colors.textMuted,
              ),
              const SizedBox(height: 24),

              // --- EMPTY STATE MESSAGE ---
              // The message text as specified in SSOT 5.1.
              Text(
                'No measurements yet.',
                style: AppTheme.typography.title.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // --- CALL TO ACTION (CTA) BUTTON ---
              // The CTA guides the user to add their first measurement.
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement navigation to the add measurement flow.
                  print('Add Measurement button pressed!');
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: const Text('Add Measurement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}