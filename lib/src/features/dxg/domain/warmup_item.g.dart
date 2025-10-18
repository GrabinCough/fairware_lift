// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warmup_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarmupItemImpl _$$WarmupItemImplFromJson(Map<String, dynamic> json) =>
    _$WarmupItemImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      region: json['region'] as String,
      pattern: json['pattern'] as String,
      modality: json['modality'] as String,
      displayName: json['display_name'] as String,
      parameters: (json['parameters'] as List<dynamic>?)
              ?.map((e) => WarmupParameter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WarmupItemImplToJson(_$WarmupItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'region': instance.region,
      'pattern': instance.pattern,
      'modality': instance.modality,
      'display_name': instance.displayName,
      'parameters': instance.parameters,
    };

_$WarmupParameterImpl _$$WarmupParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$WarmupParameterImpl(
      name: json['name'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$WarmupParameterImplToJson(
        _$WarmupParameterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'options': instance.options,
    };
