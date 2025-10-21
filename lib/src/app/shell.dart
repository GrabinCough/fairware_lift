// lib/src/app/shell.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/today/presentation/today_screen.dart';
import 'package:fairware_lift/src/features/programs/presentation/programs_screen.dart';
import 'package:fairware_lift/src/features/measurements/presentation/measurements_screen.dart';
import 'package:fairware_lift/src/features/settings/presentation/settings_screen.dart';
import 'package:fairware_lift/src/features/workout/presentation/start_workout_options_screen.dart';
// --- NEW IMPORT ---
import 'package:fairware_lift/src/features/prompt_studio/presentation/prompt_studio_page.dart';

// -----------------------------------------------------------------------------
// --- APP SHELL WIDGET --------------------------------------------------------
// -----------------------------------------------------------------------------

/// A stateful widget that acts as the main application shell.
///
/// This widget is responsible for creating and managing the primary UI
/// structure, including the BottomNavigationBar and the central Floating Action Button.
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

  // --- MODIFIED: Added PromptStudioPage to the list of screens ---
  static const List<Widget> _widgetOptions = <Widget>[
    TodayScreen(),
    ProgramsScreen(),
    PromptStudioPage(),
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
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // --- MODIFIED: Changed to centerFloat as per SSOT ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _onStartWorkoutPressed,
        backgroundColor: AppTheme.colors.accent,
        foregroundColor: AppTheme.colors.textPrimary,
        elevation: 4.0,
        child: const Icon(Icons.play_arrow_rounded),
      ),
      // --- MODIFIED: Replaced BottomAppBar with BottomNavigationBar ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today_rounded),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_alt_rounded), // For 'Prompt Studio'
            label: 'Studio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_rounded),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // --- STYLING TO MATCH APP THEME ---
        backgroundColor: AppTheme.colors.surface,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.colors.accent,
        unselectedItemColor: AppTheme.colors.textMuted,
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
      ),
    );
  }
}