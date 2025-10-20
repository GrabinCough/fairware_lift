// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
// Basic Info
  String? get name => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  int? get heightInches => throw _privateConstructorUsedError;
  double? get weightLbs =>
      throw _privateConstructorUsedError; // Experience & Goals
  String? get trainingAge =>
      throw _privateConstructorUsedError; // Renamed from experienceLevel
  List<String>? get primaryGoals => throw _privateConstructorUsedError;
  String? get goalDetails =>
      throw _privateConstructorUsedError; // Schedule & Equipment
  int? get daysPerWeek => throw _privateConstructorUsedError;
  int? get timePerSessionMinutes => throw _privateConstructorUsedError;
  List<String>? get equipmentAvailable =>
      throw _privateConstructorUsedError; // Health & History
  String? get constraints =>
      throw _privateConstructorUsedError; // Renamed from injuryHistory
  String? get currentStatus =>
      throw _privateConstructorUsedError; // --- NEW FIELDS ---
  String? get json1RMs =>
      throw _privateConstructorUsedError; // To hold the JSON string for 1RMs
  int? get z2LowBpm => throw _privateConstructorUsedError;
  int? get z2HighBpm => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String? name,
      int? age,
      String? gender,
      int? heightInches,
      double? weightLbs,
      String? trainingAge,
      List<String>? primaryGoals,
      String? goalDetails,
      int? daysPerWeek,
      int? timePerSessionMinutes,
      List<String>? equipmentAvailable,
      String? constraints,
      String? currentStatus,
      String? json1RMs,
      int? z2LowBpm,
      int? z2HighBpm});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? heightInches = freezed,
    Object? weightLbs = freezed,
    Object? trainingAge = freezed,
    Object? primaryGoals = freezed,
    Object? goalDetails = freezed,
    Object? daysPerWeek = freezed,
    Object? timePerSessionMinutes = freezed,
    Object? equipmentAvailable = freezed,
    Object? constraints = freezed,
    Object? currentStatus = freezed,
    Object? json1RMs = freezed,
    Object? z2LowBpm = freezed,
    Object? z2HighBpm = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      heightInches: freezed == heightInches
          ? _value.heightInches
          : heightInches // ignore: cast_nullable_to_non_nullable
              as int?,
      weightLbs: freezed == weightLbs
          ? _value.weightLbs
          : weightLbs // ignore: cast_nullable_to_non_nullable
              as double?,
      trainingAge: freezed == trainingAge
          ? _value.trainingAge
          : trainingAge // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryGoals: freezed == primaryGoals
          ? _value.primaryGoals
          : primaryGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goalDetails: freezed == goalDetails
          ? _value.goalDetails
          : goalDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      daysPerWeek: freezed == daysPerWeek
          ? _value.daysPerWeek
          : daysPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      timePerSessionMinutes: freezed == timePerSessionMinutes
          ? _value.timePerSessionMinutes
          : timePerSessionMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      equipmentAvailable: freezed == equipmentAvailable
          ? _value.equipmentAvailable
          : equipmentAvailable // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      json1RMs: freezed == json1RMs
          ? _value.json1RMs
          : json1RMs // ignore: cast_nullable_to_non_nullable
              as String?,
      z2LowBpm: freezed == z2LowBpm
          ? _value.z2LowBpm
          : z2LowBpm // ignore: cast_nullable_to_non_nullable
              as int?,
      z2HighBpm: freezed == z2HighBpm
          ? _value.z2HighBpm
          : z2HighBpm // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      int? age,
      String? gender,
      int? heightInches,
      double? weightLbs,
      String? trainingAge,
      List<String>? primaryGoals,
      String? goalDetails,
      int? daysPerWeek,
      int? timePerSessionMinutes,
      List<String>? equipmentAvailable,
      String? constraints,
      String? currentStatus,
      String? json1RMs,
      int? z2LowBpm,
      int? z2HighBpm});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? heightInches = freezed,
    Object? weightLbs = freezed,
    Object? trainingAge = freezed,
    Object? primaryGoals = freezed,
    Object? goalDetails = freezed,
    Object? daysPerWeek = freezed,
    Object? timePerSessionMinutes = freezed,
    Object? equipmentAvailable = freezed,
    Object? constraints = freezed,
    Object? currentStatus = freezed,
    Object? json1RMs = freezed,
    Object? z2LowBpm = freezed,
    Object? z2HighBpm = freezed,
  }) {
    return _then(_$UserProfileImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      heightInches: freezed == heightInches
          ? _value.heightInches
          : heightInches // ignore: cast_nullable_to_non_nullable
              as int?,
      weightLbs: freezed == weightLbs
          ? _value.weightLbs
          : weightLbs // ignore: cast_nullable_to_non_nullable
              as double?,
      trainingAge: freezed == trainingAge
          ? _value.trainingAge
          : trainingAge // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryGoals: freezed == primaryGoals
          ? _value._primaryGoals
          : primaryGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goalDetails: freezed == goalDetails
          ? _value.goalDetails
          : goalDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      daysPerWeek: freezed == daysPerWeek
          ? _value.daysPerWeek
          : daysPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      timePerSessionMinutes: freezed == timePerSessionMinutes
          ? _value.timePerSessionMinutes
          : timePerSessionMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      equipmentAvailable: freezed == equipmentAvailable
          ? _value._equipmentAvailable
          : equipmentAvailable // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      json1RMs: freezed == json1RMs
          ? _value.json1RMs
          : json1RMs // ignore: cast_nullable_to_non_nullable
              as String?,
      z2LowBpm: freezed == z2LowBpm
          ? _value.z2LowBpm
          : z2LowBpm // ignore: cast_nullable_to_non_nullable
              as int?,
      z2HighBpm: freezed == z2HighBpm
          ? _value.z2HighBpm
          : z2HighBpm // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {this.name,
      this.age,
      this.gender,
      this.heightInches,
      this.weightLbs,
      this.trainingAge,
      final List<String>? primaryGoals,
      this.goalDetails,
      this.daysPerWeek,
      this.timePerSessionMinutes,
      final List<String>? equipmentAvailable,
      this.constraints,
      this.currentStatus,
      this.json1RMs,
      this.z2LowBpm,
      this.z2HighBpm})
      : _primaryGoals = primaryGoals,
        _equipmentAvailable = equipmentAvailable;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

// Basic Info
  @override
  final String? name;
  @override
  final int? age;
  @override
  final String? gender;
  @override
  final int? heightInches;
  @override
  final double? weightLbs;
// Experience & Goals
  @override
  final String? trainingAge;
// Renamed from experienceLevel
  final List<String>? _primaryGoals;
// Renamed from experienceLevel
  @override
  List<String>? get primaryGoals {
    final value = _primaryGoals;
    if (value == null) return null;
    if (_primaryGoals is EqualUnmodifiableListView) return _primaryGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? goalDetails;
// Schedule & Equipment
  @override
  final int? daysPerWeek;
  @override
  final int? timePerSessionMinutes;
  final List<String>? _equipmentAvailable;
  @override
  List<String>? get equipmentAvailable {
    final value = _equipmentAvailable;
    if (value == null) return null;
    if (_equipmentAvailable is EqualUnmodifiableListView)
      return _equipmentAvailable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Health & History
  @override
  final String? constraints;
// Renamed from injuryHistory
  @override
  final String? currentStatus;
// --- NEW FIELDS ---
  @override
  final String? json1RMs;
// To hold the JSON string for 1RMs
  @override
  final int? z2LowBpm;
  @override
  final int? z2HighBpm;

  @override
  String toString() {
    return 'UserProfile(name: $name, age: $age, gender: $gender, heightInches: $heightInches, weightLbs: $weightLbs, trainingAge: $trainingAge, primaryGoals: $primaryGoals, goalDetails: $goalDetails, daysPerWeek: $daysPerWeek, timePerSessionMinutes: $timePerSessionMinutes, equipmentAvailable: $equipmentAvailable, constraints: $constraints, currentStatus: $currentStatus, json1RMs: $json1RMs, z2LowBpm: $z2LowBpm, z2HighBpm: $z2HighBpm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.heightInches, heightInches) ||
                other.heightInches == heightInches) &&
            (identical(other.weightLbs, weightLbs) ||
                other.weightLbs == weightLbs) &&
            (identical(other.trainingAge, trainingAge) ||
                other.trainingAge == trainingAge) &&
            const DeepCollectionEquality()
                .equals(other._primaryGoals, _primaryGoals) &&
            (identical(other.goalDetails, goalDetails) ||
                other.goalDetails == goalDetails) &&
            (identical(other.daysPerWeek, daysPerWeek) ||
                other.daysPerWeek == daysPerWeek) &&
            (identical(other.timePerSessionMinutes, timePerSessionMinutes) ||
                other.timePerSessionMinutes == timePerSessionMinutes) &&
            const DeepCollectionEquality()
                .equals(other._equipmentAvailable, _equipmentAvailable) &&
            (identical(other.constraints, constraints) ||
                other.constraints == constraints) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.json1RMs, json1RMs) ||
                other.json1RMs == json1RMs) &&
            (identical(other.z2LowBpm, z2LowBpm) ||
                other.z2LowBpm == z2LowBpm) &&
            (identical(other.z2HighBpm, z2HighBpm) ||
                other.z2HighBpm == z2HighBpm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      age,
      gender,
      heightInches,
      weightLbs,
      trainingAge,
      const DeepCollectionEquality().hash(_primaryGoals),
      goalDetails,
      daysPerWeek,
      timePerSessionMinutes,
      const DeepCollectionEquality().hash(_equipmentAvailable),
      constraints,
      currentStatus,
      json1RMs,
      z2LowBpm,
      z2HighBpm);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {final String? name,
      final int? age,
      final String? gender,
      final int? heightInches,
      final double? weightLbs,
      final String? trainingAge,
      final List<String>? primaryGoals,
      final String? goalDetails,
      final int? daysPerWeek,
      final int? timePerSessionMinutes,
      final List<String>? equipmentAvailable,
      final String? constraints,
      final String? currentStatus,
      final String? json1RMs,
      final int? z2LowBpm,
      final int? z2HighBpm}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

// Basic Info
  @override
  String? get name;
  @override
  int? get age;
  @override
  String? get gender;
  @override
  int? get heightInches;
  @override
  double? get weightLbs; // Experience & Goals
  @override
  String? get trainingAge; // Renamed from experienceLevel
  @override
  List<String>? get primaryGoals;
  @override
  String? get goalDetails; // Schedule & Equipment
  @override
  int? get daysPerWeek;
  @override
  int? get timePerSessionMinutes;
  @override
  List<String>? get equipmentAvailable; // Health & History
  @override
  String? get constraints; // Renamed from injuryHistory
  @override
  String? get currentStatus; // --- NEW FIELDS ---
  @override
  String? get json1RMs; // To hold the JSON string for 1RMs
  @override
  int? get z2LowBpm;
  @override
  int? get z2HighBpm;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
