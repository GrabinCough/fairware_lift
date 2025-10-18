// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovementFamilyImpl _$$MovementFamilyImplFromJson(Map<String, dynamic> json) =>
    _$MovementFamilyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      pattern: $enumDecode(_$MovementPatternEnumMap, json['pattern']),
      primary_muscles: (json['primary_muscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      secondary_muscles: (json['secondary_muscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowed: AllowedDiscriminators.fromJson(
          json['allowed'] as Map<String, dynamic>),
      denies: (json['denies'] as List<dynamic>?)
              ?.map((e) => DenyRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      display_name_template: json['display_name_template'] as String,
      naming_rules: (json['naming_rules'] as List<dynamic>?)
              ?.map((e) => NamingRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      aliases: (json['aliases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$MovementFamilyImplToJson(
        _$MovementFamilyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pattern': _$MovementPatternEnumMap[instance.pattern]!,
      'primary_muscles': instance.primary_muscles,
      'secondary_muscles': instance.secondary_muscles,
      'allowed': instance.allowed,
      'denies': instance.denies,
      'display_name_template': instance.display_name_template,
      'naming_rules': instance.naming_rules,
      'aliases': instance.aliases,
      'notes': instance.notes,
    };

const _$MovementPatternEnumMap = {
  MovementPattern.push: 'push',
  MovementPattern.pull: 'pull',
  MovementPattern.squat: 'squat',
  MovementPattern.hinge: 'hinge',
  MovementPattern.lunge: 'lunge',
  MovementPattern.carry: 'carry',
  MovementPattern.rotate: 'rotate',
  MovementPattern.anti_rotate: 'anti_rotate',
  MovementPattern.gait: 'gait',
  MovementPattern.isolation: 'isolation',
};

_$AllowedDiscriminatorsImpl _$$AllowedDiscriminatorsImplFromJson(
        Map<String, dynamic> json) =>
    _$AllowedDiscriminatorsImpl(
      equipment: (json['equipment'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      angle:
          (json['angle'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      unilateral: (json['unilateral'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      orientation: (json['orientation'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      attachment: (json['attachment'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      grip:
          (json['grip'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$AllowedDiscriminatorsImplToJson(
        _$AllowedDiscriminatorsImpl instance) =>
    <String, dynamic>{
      'equipment': instance.equipment,
      'angle': instance.angle,
      'unilateral': instance.unilateral,
      'orientation': instance.orientation,
      'attachment': instance.attachment,
      'grip': instance.grip,
    };

_$DenyRuleImpl _$$DenyRuleImplFromJson(Map<String, dynamic> json) =>
    _$DenyRuleImpl(
      equipment: json['equipment'] as String?,
      attachment: (json['attachment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$DenyRuleImplToJson(_$DenyRuleImpl instance) =>
    <String, dynamic>{
      'equipment': instance.equipment,
      'attachment': instance.attachment,
    };

_$NamingRuleImpl _$$NamingRuleImplFromJson(Map<String, dynamic> json) =>
    _$NamingRuleImpl(
      ifCondition: Map<String, String>.from(json['if'] as Map),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$NamingRuleImplToJson(_$NamingRuleImpl instance) =>
    <String, dynamic>{
      'if': instance.ifCondition,
      'name': instance.name,
    };
