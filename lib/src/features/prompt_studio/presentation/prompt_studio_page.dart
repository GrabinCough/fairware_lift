// lib/src/features/prompt_studio/presentation/prompt_studio_page.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/prompt_studio/presentation/widgets/prompt_card.dart';
import 'package:fairware_lift/src/features/prompt_studio/presentation/sheets/coach_setup_sheet.dart';
import 'package:fairware_lift/src/features/prompt_studio/presentation/sheets/data_whisperer_sheet.dart';
import 'package:fairware_lift/src/features/prompt_studio/presentation/sheets/coach_switchboard_sheet.dart';

// -----------------------------------------------------------------------------
// --- PROMPT STUDIO PAGE WIDGET -----------------------------------------------
// -----------------------------------------------------------------------------

/// The main page for the "Prompt Studio" feature, acting as a creative hub.
class PromptStudioPage extends StatelessWidget {
  const PromptStudioPage({super.key});

  /// A helper method to show a builder sheet modally.
  void _showBuilderSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF181818), // bg.surface
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.sizing.cardRadius)),
          ),
          child: sheet,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Studio'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Text(
            'Build prompts that talk your language. Copy → Paste → Coach.',
            style: AppTheme.typography.caption,
          ),
        ),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PromptCard(
            title: 'Coach Setup',
            subtitle: 'Build your AI’s first impression.',
            // --- MODIFIED: Reverted to IconData and unified color ---
            icon: Icons.person_add_alt_1_rounded,
            color: AppTheme.colors.accentRust,
            onTap: () => _showBuilderSheet(context, const CoachSetupSheet()),
          ),
          const SizedBox(height: 16),
          PromptCard(
            title: 'Data Whisperer',
            subtitle: 'Turn logs into insights.',
            // --- MODIFIED: Reverted to IconData and unified color ---
            icon: Icons.insights_rounded,
            color: AppTheme.colors.accentRust,
            onTap: () => _showBuilderSheet(context, const DataWhispererSheet()),
          ),
          const SizedBox(height: 16),
          PromptCard(
            title: 'Coach Switchboard',
            subtitle: 'Bring a new model up to speed.',
            // --- MODIFIED: Reverted to IconData and unified color ---
            icon: Icons.sync_alt_rounded,
            color: AppTheme.colors.accentRust,
            onTap: () => _showBuilderSheet(context, const CoachSwitchboardSheet()),
          ),
        ],
      ),
    );
  }
}