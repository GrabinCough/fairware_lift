// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// Import the screens for each tab.
import 'package:fairware_lift/src/features/today/presentation/today_screen.dart';
import 'package:fairware_lift/src/features/programs/presentation/programs_screen.dart';
import 'package:fairware_lift/src/features/measurements/presentation/measurements_screen.dart';
import 'package:fairware_lift/src/features/settings/presentation/settings_screen.dart';

// The screen for workout options.
import 'package:fairware_lift/src/features/workout/presentation/start_workout_options_screen.dart';


// -----------------------------------------------------------------------------
// --- APP SHELL WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful widget that acts as the main application shell.
///
/// This widget is responsible for creating and managing the primary UI
/// structure, including the notched BottomAppBar, the main content area, and
/// the docked Floating Action Button.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // ---------------------------------------------------------------------------
  // --- STATE -----------------------------------------------------------------
  // ---------------------------------------------------------------------------

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TodayScreen(),
    ProgramsScreen(),
    MeasurementsScreen(),
    SettingsScreen(),
  ];

  // ---------------------------------------------------------------------------
  // --- METHODS ---------------------------------------------------------------
  // ---------------------------------------------------------------------------

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onStartWorkoutPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.colors.surface,
      builder: (context) => const StartWorkoutOptionsScreen(),
    );
  }

  // ---------------------------------------------------------------------------
  // --- BUILD METHOD ----------------------------------------------------------
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _onStartWorkoutPressed,
        backgroundColor: AppTheme.colors.accent,
        foregroundColor: AppTheme.colors.textPrimary,
        elevation: 4.0,
        child: const Icon(Icons.play_arrow_rounded),
      ),

      // --- LAYOUT FIX: BottomAppBar with simplified IconButtons ---
      // This implementation uses a more compact and standard way to display
      // navigation items in a notched app bar, resolving the overflow issue.
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: AppTheme.colors.surfaceAlt,
        notchMargin: 8.0,
        child: Row(
          // `spaceAround` provides even horizontal spacing.
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavIcon(icon: Icons.today_rounded, index: 0),
            _buildNavIcon(icon: Icons.list_alt_rounded, index: 1),
            // The spacer creates the gap for the FAB.
            const SizedBox(width: 48),
            _buildNavIcon(icon: Icons.monitor_weight_rounded, index: 2),
            _buildNavIcon(icon: Icons.settings_rounded, index: 3),
          ],
        ),
      ),
    );
  }

  /// A helper widget to build a compact IconButton for the BottomAppBar.
  Widget _buildNavIcon({
    required IconData icon,
    required int index,
  }) {
    // Determine the color based on whether the icon is selected.
    final color = _selectedIndex == index
        ? AppTheme.colors.accent
        : AppTheme.colors.textMuted;

    return IconButton(
      icon: Icon(icon, color: color, size: 28),
      onPressed: () => _onItemTapped(index),
      // Adding a tooltip for accessibility.
      tooltip: ['Today', 'Programs', 'Measurements', 'Settings'][index],
    );
  }
}