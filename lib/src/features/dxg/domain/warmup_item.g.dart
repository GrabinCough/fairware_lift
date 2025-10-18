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
    );

Map<String, dynamic> _$$WarmupItemImplToJson(_$WarmupItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'region': instance.region,
      'pattern': instance.pattern,
      'modality': instance.modality,
      'display_name': instance.displayName,
    };
