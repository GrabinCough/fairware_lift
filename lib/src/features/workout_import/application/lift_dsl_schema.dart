 // lib/src/features/workout_import/application/lift_dsl_schema.dart

// -----------------------------------------------------------------------------
// --- LIFT DSL V1 SCHEMA ------------------------------------------------------
// -----------------------------------------------------------------------------
// This file contains the canonical JSON schema for the `lift.v1` workout DSL.
// It serves as the single source of truth for validating the structure of
// pasted workout text.
// -----------------------------------------------------------------------------

const String liftV1JsonSchema = r'''
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Fairware Lift Workout DSL v1",
  "type": "object",
  "required": ["version", "workout"],
  "properties": {
    "version": { "const": "lift.v1" },
    "workout": {
      "type": "object",
      "required": ["title", "blocks"],
      "properties": {
        "title": { "type": "string", "minLength": 1 },
        "notes": { "type": "string" },
        "blocks": {
          "type": "array",
          "minItems": 1,
          "items": {
            "type": "object",
            "required": ["type", "exercises"],
            "properties": {
              "type": { "enum": ["straight", "superset", "triset", "warmup", "finisher"] },
              "label": { "type": "string" },
              "rounds": { "type": "integer", "minimum": 1 },
              "exercises": {
                "type": "array",
                "minItems": 1,
                "items": {
                  "type": "object",
                  "required": ["name"],
                  "properties": {
                    "name": { "type": "string", "minLength": 1 },
                    "variation": { "type": "object", "additionalProperties": { "type": ["string","number","boolean"] } },
                    "prescription": {
                      "type": "object",
                      "properties": {
                        "sets": { "type": "integer", "minimum": 1 },
                        "reps": { "type": ["string","integer"] },
                        "intensity": {
                          "type": "object",
                          "properties": {
                            "type": { "enum": ["RPE","percent_1RM","load","rir"] },
                            "target": { "type": "number" },
                            "value": { "type": "number" },
                            "kg": { "type": "number" },
                            "lb": { "type": "number" },
                            "rir": { "type": "number" }
                          },
                          "additionalProperties": false
                        },
                        "rest_seconds": { "type": "integer", "minimum": 0 },
                        "rest_seconds_after": { "type": "integer", "minimum": 0 },
                        "note": { "type": "string" }
                      },
                      "additionalProperties": false
                    },
                    "metadata": {
                      "type": "object",
                      "properties": {
                        "aliases": { "type": "array", "items": { "type": "string" } },
                        "equipment": { "type": "array", "items": { "type": "string" } },
                        "primary_muscles": { "type": "array", "items": { "type": "string" } }
                      },
                      "additionalProperties": false
                    }
                  },
                  "additionalProperties": false
                }
              }
            },
            "additionalProperties": false
          }
        }
      },
      "additionalProperties": false
    }
  },
  "additionalProperties": false
}
''';