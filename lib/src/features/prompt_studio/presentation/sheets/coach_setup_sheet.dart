// lib/src/features/prompt_studio/presentation/sheets/coach_setup_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/user_profile/application/user_profile_service.dart';
import 'package:fairware_lift/src/features/user_profile/domain/user_profile.dart';
import 'package:fairware_lift/src/features/prompt_studio/application/prompt_compiler.dart';

// -----------------------------------------------------------------------------
// --- COACH SETUP SHEET WIDGET ------------------------------------------------
// -----------------------------------------------------------------------------

class CoachSetupSheet extends ConsumerStatefulWidget {
  const CoachSetupSheet({super.key});

  @override
  ConsumerState<CoachSetupSheet> createState() => _CoachSetupSheetState();
}

class _CoachSetupSheetState extends ConsumerState<CoachSetupSheet> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _profile;

  @override
  void initState() {
    super.initState();
    // Initialize the form with existing user data or a new profile.
    _profile = ref.read(userProfileProvider).value ?? const UserProfile();
  }

  void _generatePrompt() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the updated profile.
      ref.read(userProfileProvider.notifier).save(_profile);
      // Compile the prompt using the new service.
      final prompt = ref.read(promptCompilerProvider).compileCoachSetupPrompt(_profile);
      _showPromptDialog(prompt);
    }
  }

  void _showPromptDialog(String prompt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.colors.surface,
        title: const Text('Your Onboarding Prompt'),
        content: SingleChildScrollView(
          child: Text(prompt, style: const TextStyle(fontFamily: 'monospace')),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: prompt));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prompt copied to clipboard!')),
              );
            },
            child: const Text('Copy to Clipboard'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Meet Your New Coach 🤝'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Text(
              "We'll write your AI intro — you fill in the details.",
              textAlign: TextAlign.center,
              style: AppTheme.typography.body,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('About You'),
            Row(
              children: [
                Expanded(child: _buildTextFormField(
                  label: 'Name',
                  initialValue: _profile.name,
                  onSaved: (value) => _profile = _profile.copyWith(name: value),
                )),
                const SizedBox(width: 16),
                Expanded(child: _buildTextFormField(
                  label: 'Age',
                  initialValue: _profile.age?.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _profile = _profile.copyWith(age: int.tryParse(value ?? '')),
                )),
                const SizedBox(width: 16),
                Expanded(child: _buildTextFormField(
                  label: 'Weight (lbs)',
                  initialValue: _profile.weightLbs?.toString(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onSaved: (value) => _profile = _profile.copyWith(weightLbs: double.tryParse(value ?? '')),
                )),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Motivation Style'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Chill', 'Science-y', 'Hype', 'Drill Serg.'].map((style) {
                return ChoiceChip(
                  label: Text(style),
                  selected: _profile.motivationStyle == style,
                  onSelected: (selected) {
                    setState(() {
                      _profile = _profile.copyWith(motivationStyle: selected ? style : null);
                    });
                  },
                  backgroundColor: AppTheme.colors.surface,
                  selectedColor: AppTheme.colors.accentRust,
                  labelStyle: TextStyle(
                    color: _profile.motivationStyle == style
                        ? AppTheme.colors.textPrimary
                        : AppTheme.colors.textSecondary,
                  ),
                );
              }).toList(),
            ),
            // ... Add other form sections here ...
            const SizedBox(height: 100), // Space for the floating button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _generatePrompt,
        backgroundColor: AppTheme.colors.accentRust,
        icon: const Icon(Icons.preview_rounded),
        label: const Text('Generate Preview'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: AppTheme.typography.body.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    String? initialValue,
    required FormFieldSetter<String> onSaved,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.typography.body.copyWith(color: AppTheme.colors.textMuted),
        filled: true,
        fillColor: AppTheme.colors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}