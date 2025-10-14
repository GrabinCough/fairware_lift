// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// Core Flutter material design library.
import 'package:flutter/material.dart';

// The application's design system for consistent styling.
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- SETTINGS SCREEN WIDGET --------------------------------------------------
// -----------------------------------------------------------------------------

/// The screen for managing application settings and user-related options.
///
/// This screen provides a list of actions and navigation points for various
/// settings, such as profile, preferences, and data management.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A Scaffold provides the basic visual layout structure for the screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      // A ListView is used to create a scrollable list of settings options.
      body: ListView(
        children: [
          // --- ACCOUNT SECTION ---
          _buildSectionHeader('Account'),
          _buildListTile(
            icon: Icons.person_outline_rounded,
            title: 'Profile',
            subtitle: 'Manage your name, email, and goals',
            onTap: () {
              // TODO: Navigate to Profile screen.
              print('Profile tapped');
            },
          ),
          _buildListTile(
            icon: Icons.cloud_sync_outlined,
            title: 'Sync Status',
            subtitle: 'View data sync and conflict logs',
            onTap: () {
              // TODO: Navigate to Sync Status screen.
              print('Sync Status tapped');
            },
          ),

          // --- DATA SECTION ---
          _buildSectionHeader('Data'),
          _buildListTile(
            icon: Icons.upload_file_rounded,
            title: 'Export Data',
            subtitle: 'Export your workout history as CSV or PDF',
            onTap: () {
              // TODO: Navigate to Export screen.
              print('Export Data tapped');
            },
          ),

          // --- GENERAL SECTION ---
          _buildSectionHeader('General'),
          _buildListTile(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Switch between dark and light themes',
            onTap: () {
              // TODO: Show theme switcher dialog.
              print('Appearance tapped');
            },
          ),
          _buildListTile(
            icon: Icons.info_outline_rounded,
            title: 'About',
            subtitle: 'View app version and licenses',
            onTap: () {
              // TODO: Navigate to About screen.
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