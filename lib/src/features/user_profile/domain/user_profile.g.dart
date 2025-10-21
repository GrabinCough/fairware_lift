// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      heightInches: (json['heightInches'] as num?)?.toInt(),
      weightLbs: (json['weightLbs'] as num?)?.toDouble(),
      trainingAge: json['trainingAge'] as String?,
      primaryGoals: (json['primaryGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      goalDetails: json['goalDetails'] as String?,
      motivationStyle: json['motivationStyle'] as String?,
      daysPerWeek: (json['daysPerWeek'] as num?)?.toInt(),
      timePerSessionMinutes: (json['timePerSessionMinutes'] as num?)?.toInt(),
      equipmentAvailable: (json['equipmentAvailable'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      constraints: json['constraints'] as String?,
      currentStatus: json['currentStatus'] as String?,
      json1RMs: json['json1RMs'] as String?,
      z2LowBpm: (json['z2LowBpm'] as num?)?.toInt(),
      z2HighBpm: (json['z2HighBpm'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'heightInches': instance.heightInches,
      'weightLbs': instance.weightLbs,
      'trainingAge': instance.trainingAge,
      'primaryGoals': instance.primaryGoals,
      'goalDetails': instance.goalDetails,
      'motivationStyle': instance.motivationStyle,
      'daysPerWeek': instance.daysPerWeek,
      'timePerSessionMinutes': instance.timePerSessionMinutes,
      'equipmentAvailable': instance.equipmentAvailable,
      'constraints': instance.constraints,
      'currentStatus': instance.currentStatus,
      'json1RMs': instance.json1RMs,
      'z2LowBpm': instance.z2LowBpm,
      'z2HighBpm': instance.z2HighBpm,
    };
