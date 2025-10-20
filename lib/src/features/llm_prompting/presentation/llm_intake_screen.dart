 // lib/src/features/llm_prompting/presentation/llm_intake_screen.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';
import 'package:fairware_lift/src/features/user_profile/application/user_profile_service.dart';
import 'package:fairware_lift/src/features/user_profile/domain/user_profile.dart';
import 'package:fairware_lift/src/features/llm_prompting/application/prompt_generation_service.dart';

// -----------------------------------------------------------------------------
// --- LLM INTAKE SCREEN WIDGET ------------------------------------------------
// -----------------------------------------------------------------------------

class LlmIntakeScreen extends ConsumerStatefulWidget {
  const LlmIntakeScreen({super.key});

  @override
  ConsumerState<LlmIntakeScreen> createState() => _LlmIntakeScreenState();
}

class _LlmIntakeScreenState extends ConsumerState<LlmIntakeScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _profile;

  @override
  void initState() {
    super.initState();
    // Initialize with an empty profile, or load the existing one.
    _profile = ref.read(userProfileProvider).value ?? const UserProfile();
  }

  void _generatePrompt() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the profile for next time.
      ref.read(userProfileProvider.notifier).save(_profile);
      // Generate the prompt string.
      final prompt = ref.read(promptGenerationServiceProvider).createOnboardingPrompt(_profile);
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
      appBar: AppBar(
        title: const Text('Onboard New LLM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_all_rounded),
            onPressed: _generatePrompt,
            tooltip: 'Generate Prompt',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader('Basic Info'),
            _buildTextFormField(
              label: 'Name',
              initialValue: _profile.name,
              onSaved: (value) => _profile = _profile.copyWith(name: value),
            ),
            _buildTextFormField(
              label: 'Age',
              initialValue: _profile.age?.toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => _profile = _profile.copyWith(age: int.tryParse(value ?? '')),
            ),
            _buildTextFormField(
              label: 'Weight (lbs)',
              initialValue: _profile.weightLbs?.toString(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSaved: (value) => _profile = _profile.copyWith(weightLbs: double.tryParse(value ?? '')),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Experience & Goals'),
            _buildTextFormField(
              label: 'Experience Level (e.g., Beginner, Intermediate)',
              initialValue: _profile.experienceLevel,
              onSaved: (value) => _profile = _profile.copyWith(experienceLevel: value),
            ),
            _buildTextFormField(
              label: 'Primary Goals (comma separated)',
              initialValue: _profile.primaryGoals?.join(', '),
              onSaved: (value) => _profile = _profile.copyWith(primaryGoals: value?.split(',').map((e) => e.trim()).toList()),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Logistics'),
            _buildTextFormField(
              label: 'Available Equipment (comma separated)',
              initialValue: _profile.equipmentAvailable?.join(', '),
              onSaved: (value) => _profile = _profile.copyWith(equipmentAvailable: value?.split(',').map((e) => e.trim()).toList()),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Health & History'),
            _buildTextFormField(
              label: 'Injury History & Considerations',
              initialValue: _profile.injuryHistory,
              onSaved: (value) => _profile = _profile.copyWith(injuryHistory: value),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title, style: AppTheme.typography.title),
    );
  }

  Widget _buildTextFormField({
    required String label,
    String? initialValue,
    required FormFieldSetter<String> onSaved,
    TextInputType? keyboardType,
    int? maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        onSaved: onSaved,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppTheme.colors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.sizing.cardRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}