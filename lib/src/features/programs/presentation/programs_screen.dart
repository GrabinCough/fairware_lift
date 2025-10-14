// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- PROGRAMS SCREEN WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for managing user-created workout programs.
///
/// As defined in the SSOT, this screen will list all of the user's programs.
/// This implementation shows the "Empty State" UI (SSOT 5.1) which is displayed
/// when the user has not created any programs yet.
class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for the screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programs'),
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
                Icons.list_alt_rounded,
                size: 80,
                color: AppTheme.colors.textMuted,
              ),
              const SizedBox(height: 24),

              // --- EMPTY STATE MESSAGE ---
              // The message text as specified in SSOT 5.1.
              Text(
                'No programs. Start from a template or create your own.',
                style: AppTheme.typography.title.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // --- CALL TO ACTION (CTA) BUTTON ---
              // The CTA to guide the user to the next step.
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement navigation to the program builder.
                  print('Create Program button pressed!');
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: const Text('Create Program'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}