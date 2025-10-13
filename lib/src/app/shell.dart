// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// Import the placeholder screens for each tab.
import 'package:fairware_lift/src/features/today/presentation/today_screen.dart';
import 'package:fairware_lift/src/features/programs/presentation/programs_screen.dart';
import 'package:fairware_lift/src/features/history/presentation/history_screen.dart';
import 'package:fairware_lift/src/features/measurements/presentation/measurements_screen.dart';
import 'package:fairware_lift/src/features/settings/presentation/settings_screen.dart';

// -----------------------------------------------------------------------------
// --- APP SHELL WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful widget that acts as the main application shell.
///
/// This widget is responsible for creating and managing the primary UI
/// structure, including the BottomNavigationBar, the main content area, and
/// global UI elements like the Floating Action Button.
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
    HistoryScreen(),
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
    // TODO: Implement navigation to the workout flow.
    print('Start Workout FAB pressed!');
  }

  // ---------------------------------------------------------------------------
  // --- BUILD METHOD ----------------------------------------------------------
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),

      // --- FINAL LAYOUT: FAB floats cleanly above the bar ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _onStartWorkoutPressed,
        backgroundColor: AppTheme.colors.accent,
        foregroundColor: AppTheme.colors.textPrimary,
        child: const Icon(Icons.play_arrow_rounded),
      ),

      // --- FINAL LAYOUT: Standard BottomNavigationBar with 5 items ---
      // This is a robust, clean, and maintainable implementation.
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.colors.surfaceAlt,
        selectedItemColor: AppTheme.colors.accent,
        unselectedItemColor: AppTheme.colors.textMuted,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            activeIcon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Programs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_outlined),
            activeIcon: Icon(Icons.monitor_weight),
            label: 'Measurements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}