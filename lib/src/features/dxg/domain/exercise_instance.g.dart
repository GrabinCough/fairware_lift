// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseInstance _$ExerciseInstanceFromJson(Map<String, dynamic> json) =>
    ExerciseInstance(
      slug: json['slug'] as String,
      familyId: json['familyId'] as String,
      displayName: json['displayName'] as String,
      discriminators: Map<String, String>.from(json['discriminators'] as Map),
      firstSeenAt: DateTime.parse(json['firstSeenAt'] as String),
    );

Map<String, dynamic> _$ExerciseInstanceToJson(ExerciseInstance instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'familyId': instance.familyId,
      'displayName': instance.displayName,
      'discriminators': instance.discriminators,
      'firstSeenAt': instance.firstSeenAt.toIso8601String(),
    };
