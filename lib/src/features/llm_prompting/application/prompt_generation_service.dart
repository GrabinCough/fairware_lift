// lib/src/features/llm_prompting/application/prompt_generation_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/user_profile/domain/user_profile.dart';

// -----------------------------------------------------------------------------
// --- PROMPT GENERATION SERVICE -----------------------------------------------
// -----------------------------------------------------------------------------

/// A service dedicated to constructing formatted prompt strings.
class PromptGenerationService {
  /// --- REWRITTEN ---
  /// Creates a detailed onboarding prompt based on the new contract.
  String createOnboardingPrompt(UserProfile profile) {
    // Helper to convert lbs to kg for the prompt.
    final weightKg = (profile.weightLbs ?? 0) * 0.453592;

    // The master prompt template.
    final promptTemplate = """
SYSTEM:
You are Fairware Lift’s Workout Formatter. Output ONLY valid JSON. No markdown, no explanations, no code fences.
Top level MUST include: "version": "lift.v1" and "workout": { ... }.

USER CONTEXT
- Body weight: {{body_weight_kg}} kg
- Training age: {{training_age}}
- Known 1RMs: {{json_1rms}}
- HR zones: Z2 {{z2_low_bpm}}–{{z2_high_bpm}} bpm
- Constraints: {{constraints}}
- Equipment available: {{equipment_list}}
- Goal today: {{goal}}
- Session length cap: {{minutes}} minutes

CONTRACT (exact shape)
{
  "version": "lift.v1",
  "workout": {
    "title": "string",
    "notes": "string optional",
    "blocks": [
      {
        "type": "straight|superset|triset|warmup|finisher",
        "label": "string optional",
        "rounds": "int optional (for superset/triset)",
        "exercises": [
          {
            "name": "string",
            "variation": {
              "freeform keys like": "grip, stance, position, tempo, implement, angle, side, assist, benchAngle, rangeCue, hold_seconds_top, hold_seconds_bottom"
            },
            "prescription": {
              "sets": "int optional unless type=straight",
              "reps": "int | 'low–high' | 'X/side' | 'AMRAP' | 'AMRAP-N'",
              "intensity": { "type": "RPE|percent_1RM|load|rir", "target|value|kg|lb|rir": "numbers optional" },
              "rest_seconds": "int optional",
              "rest_seconds_after": "int optional",
              "note": "string optional"
            },
            "info": {
              "how_to": "string optional (2–4 sentences: setup → execution → finish; cues-first)",
              "coaching_cues": ["string... optional (3–6 bullets)"],
              "common_errors": ["string... optional (2–5 bullets)"],
              "safety_notes": "string optional",
              "video_search_query": "string optional (ideal YouTube search)",
              "web_search_query": "string optional (ideal general web search)",
              "regression": "string optional (make it easier)",
              "progression": "string optional (make it harder)",
              "equipment_notes": "string optional"
            },
            "metadata": {
              "aliases": ["string..."],
              "equipment": ["string..."],
              "primary_muscles": ["string..."]
            }
          }
        ]
      }
    ]
  }
}

REQUIRED BEHAVIOR
- Use only available equipment; respect the minutes cap.
- Fill sets, reps, intensity, and rest so the workout is runnable now.
- If 1RMs unknown, prefer RPE/RIR over percent_1RM.
- For unilateral work, use reps like "10/side".
- Include meaningful aliases to aid matching (e.g., "RDL" for Romanian Deadlift).
- Populate info.* fields so the app’s ℹ️ panel is useful; search queries should be copy-ready (no URLs).

DEFAULTS THE MODEL MAY APPLY
- Straight: sets=3, reps="8–12", intensity={"type":"RPE","target":7}, rest_seconds=90
- Superset: rounds=3 if sets omitted; rest_seconds_after=0 between A1→A2, 120 between rounds
- Accessories tempo default "3-1-1" if not specified

Please confirm you understand these instructions and are ready to act as my coach. You will not generate a workout until I provide a TASK in a future prompt.
""";

    // Replace placeholders with profile data.
    return promptTemplate
        .replaceAll('{{body_weight_kg}}', weightKg.toStringAsFixed(1))
        .replaceAll('{{training_age}}', profile.trainingAge ?? 'not specified')
        .replaceAll('{{json_1rms}}', profile.json1RMs ?? '{}')
        .replaceAll('{{z2_low_bpm}}', profile.z2LowBpm?.toString() ?? 'not set')
        .replaceAll('{{z2_high_bpm}}', profile.z2HighBpm?.toString() ?? 'not set')
        .replaceAll('{{constraints}}', profile.constraints ?? 'none')
        .replaceAll('{{equipment_list}}', profile.equipmentAvailable?.join(', ') ?? 'not specified')
        .replaceAll('{{goal}}', 'a balanced workout') // Default for onboarding
        .replaceAll('{{minutes}}', profile.timePerSessionMinutes?.toString() ?? '60');
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

final promptGenerationServiceProvider = Provider<PromptGenerationService>((ref) {
  return PromptGenerationService();
});