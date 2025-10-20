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
      experienceLevel: json['experienceLevel'] as String?,
      primaryGoals: (json['primaryGoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      goalDetails: json['goalDetails'] as String?,
      daysPerWeek: (json['daysPerWeek'] as num?)?.toInt(),
      timePerSessionMinutes: (json['timePerSessionMinutes'] as num?)?.toInt(),
      equipmentAvailable: (json['equipmentAvailable'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      injuryHistory: json['injuryHistory'] as String?,
      currentStatus: json['currentStatus'] as String?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'heightInches': instance.heightInches,
      'weightLbs': instance.weightLbs,
      'experienceLevel': instance.experienceLevel,
      'primaryGoals': instance.primaryGoals,
      'goalDetails': instance.goalDetails,
      'daysPerWeek': instance.daysPerWeek,
      'timePerSessionMinutes': instance.timePerSessionMinutes,
      'equipmentAvailable': instance.equipmentAvailable,
      'injuryHistory': instance.injuryHistory,
      'currentStatus': instance.currentStatus,
    };
