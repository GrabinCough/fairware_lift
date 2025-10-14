// lib/src/features/settings/presentation/settings_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// --- NEW IMPORT ---
// Import the HistoryScreen so we can navigate to it.
import 'package:fairware_lift/src/features/history/presentation/history_screen.dart';

// -----------------------------------------------------------------------------
// --- SETTINGS SCREEN WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for managing application settings and user-related options.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Account'),
          _buildListTile(
            icon: Icons.person_outline_rounded,
            title: 'Profile',
            subtitle: 'Manage your name, email, and goals',
            onTap: () {
              print('Profile tapped');
            },
          ),
          _buildListTile(
            icon: Icons.cloud_sync_outlined,
            title: 'Sync Status',
            subtitle: 'View data sync and conflict logs',
            onTap: () {
              print('Sync Status tapped');
            },
          ),
          _buildSectionHeader('Data'),
          _buildListTile(
            icon: Icons.bar_chart_rounded,
            title: 'Workout History',
            subtitle: 'Review all your past sessions',
            // --- UI FIX ---
            // The onTap callback now navigates to the HistoryScreen.
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
          _buildListTile(
            icon: Icons.upload_file_rounded,
            title: 'Export Data',
            subtitle: 'Export your workout history as CSV or PDF',
            onTap: () {
              print('Export Data tapped');
            },
          ),
          _buildSectionHeader('General'),
          _buildListTile(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Switch between dark and light themes',
            onTap: () {
              print('Appearance tapped');
            },
          ),
          _buildListTile(
            icon: Icons.info_outline_rounded,
            title: 'About',
            subtitle: 'View app version and licenses',
            onTap: () {
              print('About tapped');
            },
          ),
        ],
      ),
    );
  }

  /// Private helper to build a consistent section header.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.typography.caption.copyWith(
          color: AppTheme.colors.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Private helper to build a consistent ListTile for settings items.
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.colors.textMuted),
      title: Text(
        title,
        style: AppTheme.typography.body.copyWith(
          color: AppTheme.colors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.typography.body.copyWith(fontSize: 14),
      ),
      onTap: onTap,
    );
  }
}