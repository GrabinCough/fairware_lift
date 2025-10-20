// lib/src/features/llm_prompting/application/prompt_generation_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/user_profile/domain/user_profile.dart';

// -----------------------------------------------------------------------------
// --- PROMPT GENERATION SERVICE -----------------------------------------------
// -----------------------------------------------------------------------------

/// A service dedicated to constructing formatted prompt strings for the user
/// to copy and paste into an external LLM.
class PromptGenerationService {
  /// Creates a detailed onboarding prompt for a new AI fitness coach.
  String createOnboardingPrompt(UserProfile profile) {
    final buffer = StringBuffer();

    buffer.writeln('Hello! I would like you to act as my expert fitness and strength coach. I will be using you to generate workout plans. To get started, here is my personal profile:');
    buffer.writeln('\n--- My Profile ---');

    if (profile.name != null) buffer.writeln('- Name: ${profile.name}');
    if (profile.age != null) buffer.writeln('- Age: ${profile.age}');
    if (profile.gender != null) buffer.writeln('- Gender: ${profile.gender}');
    if (profile.heightInches != null) buffer.writeln('- Height (inches): ${profile.heightInches}');
    if (profile.weightLbs != null) buffer.writeln('- Weight (lbs): ${profile.weightLbs}');

    buffer.writeln('\n--- Experience & Goals ---');
    if (profile.experienceLevel != null) buffer.writeln('- Experience Level: ${profile.experienceLevel}');
    if (profile.primaryGoals?.isNotEmpty ?? false) buffer.writeln('- Primary Goals: ${profile.primaryGoals!.join(', ')}');
    if (profile.goalDetails != null) buffer.writeln('- More Details on Goals: ${profile.goalDetails}');

    buffer.writeln('\n--- Logistics ---');
    if (profile.daysPerWeek != null) buffer.writeln('- Training Frequency: ${profile.daysPerWeek} days per week');
    if (profile.timePerSessionMinutes != null) buffer.writeln('- Session Duration: ~${profile.timePerSessionMinutes} minutes per workout');
    if (profile.equipmentAvailable?.isNotEmpty ?? false) buffer.writeln('- Available Equipment: ${profile.equipmentAvailable!.join(', ')}');

    buffer.writeln('\n--- Health & History ---');
    if (profile.injuryHistory != null) buffer.writeln('- Injury History & Considerations: ${profile.injuryHistory}');
    if (profile.currentStatus != null) buffer.writeln('- Current Status & Notes: ${profile.currentStatus}');

    buffer.writeln('\n--- IMPORTANT ---');
    buffer.writeln('When you generate a workout plan for me, please format it using the "lift.v1" JSON schema. This is critical for me to be able to import it into my tracking app. Do not include any other text or explanations outside of the JSON code block.');
    buffer.writeln('\nPlease confirm you understand these instructions and are ready to act as my coach.');

    return buffer.toString();
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final promptGenerationServiceProvider = Provider<PromptGenerationService>((ref) {
  return PromptGenerationService();
});