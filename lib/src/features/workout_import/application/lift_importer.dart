// lib/src/features/workout_import/application/lift_importer.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:fairware_lift/src/features/workout_import/domain/lift_dsl.dart';
import 'package:fairware_lift/src/features/workout_import/application/lift_dsl_validator.dart';
import 'package:fairware_lift/src/features/workout_import/application/lift_normalizer.dart';
import 'package:fairware_lift/src/features/workout_import/application/lift_matcher.dart';
import 'package:fairware_lift/src/features/workout_import/application/lift_hash.dart';
import 'package:fairware_lift/src/features/workout/domain/session_item.dart';
import 'package:fairware_lift/src/features/dxg/application/name_slug_service.dart';

class LowConfidenceIssue {
  final String rawName;
  LowConfidenceIssue({required this.rawName});
}

class LiftImporterOutput {
  final List<SessionItem> sessionItems;
  final List<LowConfidenceIssue> issues;
  final String? error;
  LiftImporterOutput({this.sessionItems = const [], this.issues = const [], this.error});
  bool get hasIssues => issues.isNotEmpty;
  bool get hasError => error != null;
}

class LiftImporter {
  final LiftDslValidator _validator;
  final LiftNormalizer _normalizer;
  final LiftMatcher _matcher;
  final LiftHash _hasher;
  final NameAndSlugService _nameAndSlugService;
  final Uuid _uuid = const Uuid();

  LiftImporter(this._validator, this._normalizer, this._matcher, this._hasher, this._nameAndSlugService);

  Future<LiftImporterOutput> importFromJson(String jsonString) async {
    try {
      final validationResult = _validator.parseAndValidate(jsonString);
      if (!validationResult.isValid) return LiftImporterOutput(error: validationResult.error);

      final normalizedWorkout = _normalizer.normalize(validationResult.workout!);
      final sessionItems = <SessionItem>[];
      final issues = <LowConfidenceIssue>[];

      for (final block in normalizedWorkout.workout.blocks) {
        if (block.type == BlockType.straight || block.type == BlockType.warmup || block.type == BlockType.finisher) {
          for (final exercise in block.exercises) {
            sessionItems.add(await _buildSessionExercise(exercise, issues));
          }
        } else if (block.type == BlockType.superset || block.type == BlockType.triset) {
          final supersetExercises = <SessionExercise>[];
          for (final exercise in block.exercises) {
            supersetExercises.add(await _buildSessionExercise(exercise, issues));
          }
          sessionItems.add(SessionSuperset(id: _uuid.v4(), exercises: supersetExercises));
        }
      }
      return LiftImporterOutput(sessionItems: sessionItems, issues: issues);
    } catch (e) {
      return LiftImporterOutput(error: 'An unexpected error occurred during import: ${e.toString()}');
    }
  }

  Future<SessionExercise> _buildSessionExercise(Exercise exercise, List<LowConfidenceIssue> issues) async {
    final matchResult = await _matcher.match(rawName: exercise.name, aliases: exercise.metadata?.aliases);
    if (matchResult.unmapped) issues.add(LowConfidenceIssue(rawName: exercise.name));

    final exerciseHash = _hasher.exerciseHash(exercise.name, exercise.variation);
    String? canonicalSlug;
    if (matchResult.familyId != null) {
      final discriminators = <String, String>{};
      exercise.variation?.forEach((key, value) { discriminators[key] = value.toString(); });
      canonicalSlug = _nameAndSlugService.toSlug(familyId: matchResult.familyId!, discriminators: discriminators);
    }

    return SessionExercise(
      id: _uuid.v4(),
      slug: canonicalSlug,
      exerciseHash: exerciseHash,
      displayName: exercise.name,
      prescription: exercise.prescription!,
      variation: exercise.variation ?? {},
      info: exercise.info, // NEW
      unmapped: matchResult.unmapped,
    );
  }
}

final liftDslValidatorProvider = Provider((_) => LiftDslValidator());
final liftNormalizerProvider = Provider((_) => LiftNormalizer());
final liftHashProvider = Provider((_) => LiftHash());

final liftImporterProvider = FutureProvider<LiftImporter>((ref) async {
  final matcher = await ref.watch(liftMatcherProvider.future);
  return LiftImporter(
    ref.watch(liftDslValidatorProvider),
    ref.watch(liftNormalizerProvider),
    matcher,
    ref.watch(liftHashProvider),
    ref.watch(nameAndSlugServiceProvider),
  );
});