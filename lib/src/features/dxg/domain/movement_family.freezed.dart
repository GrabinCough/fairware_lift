// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movement_family.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovementFamily _$MovementFamilyFromJson(Map<String, dynamic> json) {
  return _MovementFamily.fromJson(json);
}

/// @nodoc
mixin _$MovementFamily {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  MovementPattern get pattern => throw _privateConstructorUsedError;
  List<String> get primary_muscles => throw _privateConstructorUsedError;
  List<String> get secondary_muscles => throw _privateConstructorUsedError;
  AllowedDiscriminators get allowed => throw _privateConstructorUsedError;
  List<DenyRule> get denies => throw _privateConstructorUsedError;
  String get display_name_template => throw _privateConstructorUsedError;
  List<NamingRule> get naming_rules => throw _privateConstructorUsedError;
  List<String> get aliases => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this MovementFamily to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovementFamilyCopyWith<MovementFamily> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovementFamilyCopyWith<$Res> {
  factory $MovementFamilyCopyWith(
          MovementFamily value, $Res Function(MovementFamily) then) =
      _$MovementFamilyCopyWithImpl<$Res, MovementFamily>;
  @useResult
  $Res call(
      {String id,
      String name,
      MovementPattern pattern,
      List<String> primary_muscles,
      List<String> secondary_muscles,
      AllowedDiscriminators allowed,
      List<DenyRule> denies,
      String display_name_template,
      List<NamingRule> naming_rules,
      List<String> aliases,
      String? notes});

  $AllowedDiscriminatorsCopyWith<$Res> get allowed;
}

/// @nodoc
class _$MovementFamilyCopyWithImpl<$Res, $Val extends MovementFamily>
    implements $MovementFamilyCopyWith<$Res> {
  _$MovementFamilyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pattern = null,
    Object? primary_muscles = null,
    Object? secondary_muscles = null,
    Object? allowed = null,
    Object? denies = null,
    Object? display_name_template = null,
    Object? naming_rules = null,
    Object? aliases = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as MovementPattern,
      primary_muscles: null == primary_muscles
          ? _value.primary_muscles
          : primary_muscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      secondary_muscles: null == secondary_muscles
          ? _value.secondary_muscles
          : secondary_muscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowed: null == allowed
          ? _value.allowed
          : allowed // ignore: cast_nullable_to_non_nullable
              as AllowedDiscriminators,
      denies: null == denies
          ? _value.denies
          : denies // ignore: cast_nullable_to_non_nullable
              as List<DenyRule>,
      display_name_template: null == display_name_template
          ? _value.display_name_template
          : display_name_template // ignore: cast_nullable_to_non_nullable
              as String,
      naming_rules: null == naming_rules
          ? _value.naming_rules
          : naming_rules // ignore: cast_nullable_to_non_nullable
              as List<NamingRule>,
      aliases: null == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AllowedDiscriminatorsCopyWith<$Res> get allowed {
    return $AllowedDiscriminatorsCopyWith<$Res>(_value.allowed, (value) {
      return _then(_value.copyWith(allowed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MovementFamilyImplCopyWith<$Res>
    implements $MovementFamilyCopyWith<$Res> {
  factory _$$MovementFamilyImplCopyWith(_$MovementFamilyImpl value,
          $Res Function(_$MovementFamilyImpl) then) =
      __$$MovementFamilyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      MovementPattern pattern,
      List<String> primary_muscles,
      List<String> secondary_muscles,
      AllowedDiscriminators allowed,
      List<DenyRule> denies,
      String display_name_template,
      List<NamingRule> naming_rules,
      List<String> aliases,
      String? notes});

  @override
  $AllowedDiscriminatorsCopyWith<$Res> get allowed;
}

/// @nodoc
class __$$MovementFamilyImplCopyWithImpl<$Res>
    extends _$MovementFamilyCopyWithImpl<$Res, _$MovementFamilyImpl>
    implements _$$MovementFamilyImplCopyWith<$Res> {
  __$$MovementFamilyImplCopyWithImpl(
      _$MovementFamilyImpl _value, $Res Function(_$MovementFamilyImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pattern = null,
    Object? primary_muscles = null,
    Object? secondary_muscles = null,
    Object? allowed = null,
    Object? denies = null,
    Object? display_name_template = null,
    Object? naming_rules = null,
    Object? aliases = null,
    Object? notes = freezed,
  }) {
    return _then(_$MovementFamilyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as MovementPattern,
      primary_muscles: null == primary_muscles
          ? _value._primary_muscles
          : primary_muscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      secondary_muscles: null == secondary_muscles
          ? _value._secondary_muscles
          : secondary_muscles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowed: null == allowed
          ? _value.allowed
          : allowed // ignore: cast_nullable_to_non_nullable
              as AllowedDiscriminators,
      denies: null == denies
          ? _value._denies
          : denies // ignore: cast_nullable_to_non_nullable
              as List<DenyRule>,
      display_name_template: null == display_name_template
          ? _value.display_name_template
          : display_name_template // ignore: cast_nullable_to_non_nullable
              as String,
      naming_rules: null == naming_rules
          ? _value._naming_rules
          : naming_rules // ignore: cast_nullable_to_non_nullable
              as List<NamingRule>,
      aliases: null == aliases
          ? _value._aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovementFamilyImpl implements _MovementFamily {
  const _$MovementFamilyImpl(
      {required this.id,
      required this.name,
      required this.pattern,
      required final List<String> primary_muscles,
      required final List<String> secondary_muscles,
      required this.allowed,
      final List<DenyRule> denies = const [],
      required this.display_name_template,
      final List<NamingRule> naming_rules = const [],
      final List<String> aliases = const [],
      this.notes})
      : _primary_muscles = primary_muscles,
        _secondary_muscles = secondary_muscles,
        _denies = denies,
        _naming_rules = naming_rules,
        _aliases = aliases;

  factory _$MovementFamilyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovementFamilyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final MovementPattern pattern;
  final List<String> _primary_muscles;
  @override
  List<String> get primary_muscles {
    if (_primary_muscles is EqualUnmodifiableListView) return _primary_muscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primary_muscles);
  }

  final List<String> _secondary_muscles;
  @override
  List<String> get secondary_muscles {
    if (_secondary_muscles is EqualUnmodifiableListView)
      return _secondary_muscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secondary_muscles);
  }

  @override
  final AllowedDiscriminators allowed;
  final List<DenyRule> _denies;
  @override
  @JsonKey()
  List<DenyRule> get denies {
    if (_denies is EqualUnmodifiableListView) return _denies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_denies);
  }

  @override
  final String display_name_template;
  final List<NamingRule> _naming_rules;
  @override
  @JsonKey()
  List<NamingRule> get naming_rules {
    if (_naming_rules is EqualUnmodifiableListView) return _naming_rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_naming_rules);
  }

  final List<String> _aliases;
  @override
  @JsonKey()
  List<String> get aliases {
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aliases);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'MovementFamily(id: $id, name: $name, pattern: $pattern, primary_muscles: $primary_muscles, secondary_muscles: $secondary_muscles, allowed: $allowed, denies: $denies, display_name_template: $display_name_template, naming_rules: $naming_rules, aliases: $aliases, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovementFamilyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            const DeepCollectionEquality()
                .equals(other._primary_muscles, _primary_muscles) &&
            const DeepCollectionEquality()
                .equals(other._secondary_muscles, _secondary_muscles) &&
            (identical(other.allowed, allowed) || other.allowed == allowed) &&
            const DeepCollectionEquality().equals(other._denies, _denies) &&
            (identical(other.display_name_template, display_name_template) ||
                other.display_name_template == display_name_template) &&
            const DeepCollectionEquality()
                .equals(other._naming_rules, _naming_rules) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      pattern,
      const DeepCollectionEquality().hash(_primary_muscles),
      const DeepCollectionEquality().hash(_secondary_muscles),
      allowed,
      const DeepCollectionEquality().hash(_denies),
      display_name_template,
      const DeepCollectionEquality().hash(_naming_rules),
      const DeepCollectionEquality().hash(_aliases),
      notes);

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovementFamilyImplCopyWith<_$MovementFamilyImpl> get copyWith =>
      __$$MovementFamilyImplCopyWithImpl<_$MovementFamilyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovementFamilyImplToJson(
      this,
    );
  }
}

abstract class _MovementFamily implements MovementFamily {
  const factory _MovementFamily(
      {required final String id,
      required final String name,
      required final MovementPattern pattern,
      required final List<String> primary_muscles,
      required final List<String> secondary_muscles,
      required final AllowedDiscriminators allowed,
      final List<DenyRule> denies,
      required final String display_name_template,
      final List<NamingRule> naming_rules,
      final List<String> aliases,
      final String? notes}) = _$MovementFamilyImpl;

  factory _MovementFamily.fromJson(Map<String, dynamic> json) =
      _$MovementFamilyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  MovementPattern get pattern;
  @override
  List<String> get primary_muscles;
  @override
  List<String> get secondary_muscles;
  @override
  AllowedDiscriminators get allowed;
  @override
  List<DenyRule> get denies;
  @override
  String get display_name_template;
  @override
  List<NamingRule> get naming_rules;
  @override
  List<String> get aliases;
  @override
  String? get notes;

  /// Create a copy of MovementFamily
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovementFamilyImplCopyWith<_$MovementFamilyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AllowedDiscriminators _$AllowedDiscriminatorsFromJson(
    Map<String, dynamic> json) {
  return _AllowedDiscriminators.fromJson(json);
}

/// @nodoc
mixin _$AllowedDiscriminators {
  List<String> get equipment => throw _privateConstructorUsedError;
  List<String> get angle => throw _privateConstructorUsedError;
  List<String> get unilateral => throw _privateConstructorUsedError;
  List<String> get orientation => throw _privateConstructorUsedError;
  List<String> get attachment => throw _privateConstructorUsedError;
  List<String> get grip => throw _privateConstructorUsedError;

  /// Serializes this AllowedDiscriminators to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllowedDiscriminators
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllowedDiscriminatorsCopyWith<AllowedDiscriminators> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllowedDiscriminatorsCopyWith<$Res> {
  factory $AllowedDiscriminatorsCopyWith(AllowedDiscriminators value,
          $Res Function(AllowedDiscriminators) then) =
      _$AllowedDiscriminatorsCopyWithImpl<$Res, AllowedDiscriminators>;
  @useResult
  $Res call(
      {List<String> equipment,
      List<String> angle,
      List<String> unilateral,
      List<String> orientation,
      List<String> attachment,
      List<String> grip});
}

/// @nodoc
class _$AllowedDiscriminatorsCopyWithImpl<$Res,
        $Val extends AllowedDiscriminators>
    implements $AllowedDiscriminatorsCopyWith<$Res> {
  _$AllowedDiscriminatorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllowedDiscriminators
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = null,
    Object? angle = null,
    Object? unilateral = null,
    Object? orientation = null,
    Object? attachment = null,
    Object? grip = null,
  }) {
    return _then(_value.copyWith(
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      angle: null == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unilateral: null == unilateral
          ? _value.unilateral
          : unilateral // ignore: cast_nullable_to_non_nullable
              as List<String>,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachment: null == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      grip: null == grip
          ? _value.grip
          : grip // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllowedDiscriminatorsImplCopyWith<$Res>
    implements $AllowedDiscriminatorsCopyWith<$Res> {
  factory _$$AllowedDiscriminatorsImplCopyWith(
          _$AllowedDiscriminatorsImpl value,
          $Res Function(_$AllowedDiscriminatorsImpl) then) =
      __$$AllowedDiscriminatorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> equipment,
      List<String> angle,
      List<String> unilateral,
      List<String> orientation,
      List<String> attachment,
      List<String> grip});
}

/// @nodoc
class __$$AllowedDiscriminatorsImplCopyWithImpl<$Res>
    extends _$AllowedDiscriminatorsCopyWithImpl<$Res,
        _$AllowedDiscriminatorsImpl>
    implements _$$AllowedDiscriminatorsImplCopyWith<$Res> {
  __$$AllowedDiscriminatorsImplCopyWithImpl(_$AllowedDiscriminatorsImpl _value,
      $Res Function(_$AllowedDiscriminatorsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllowedDiscriminators
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = null,
    Object? angle = null,
    Object? unilateral = null,
    Object? orientation = null,
    Object? attachment = null,
    Object? grip = null,
  }) {
    return _then(_$AllowedDiscriminatorsImpl(
      equipment: null == equipment
          ? _value._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      angle: null == angle
          ? _value._angle
          : angle // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unilateral: null == unilateral
          ? _value._unilateral
          : unilateral // ignore: cast_nullable_to_non_nullable
              as List<String>,
      orientation: null == orientation
          ? _value._orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      attachment: null == attachment
          ? _value._attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      grip: null == grip
          ? _value._grip
          : grip // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllowedDiscriminatorsImpl implements _AllowedDiscriminators {
  const _$AllowedDiscriminatorsImpl(
      {final List<String> equipment = const [],
      final List<String> angle = const [],
      final List<String> unilateral = const [],
      final List<String> orientation = const [],
      final List<String> attachment = const [],
      final List<String> grip = const []})
      : _equipment = equipment,
        _angle = angle,
        _unilateral = unilateral,
        _orientation = orientation,
        _attachment = attachment,
        _grip = grip;

  factory _$AllowedDiscriminatorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllowedDiscriminatorsImplFromJson(json);

  final List<String> _equipment;
  @override
  @JsonKey()
  List<String> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  final List<String> _angle;
  @override
  @JsonKey()
  List<String> get angle {
    if (_angle is EqualUnmodifiableListView) return _angle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_angle);
  }

  final List<String> _unilateral;
  @override
  @JsonKey()
  List<String> get unilateral {
    if (_unilateral is EqualUnmodifiableListView) return _unilateral;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unilateral);
  }

  final List<String> _orientation;
  @override
  @JsonKey()
  List<String> get orientation {
    if (_orientation is EqualUnmodifiableListView) return _orientation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orientation);
  }

  final List<String> _attachment;
  @override
  @JsonKey()
  List<String> get attachment {
    if (_attachment is EqualUnmodifiableListView) return _attachment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachment);
  }

  final List<String> _grip;
  @override
  @JsonKey()
  List<String> get grip {
    if (_grip is EqualUnmodifiableListView) return _grip;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grip);
  }

  @override
  String toString() {
    return 'AllowedDiscriminators(equipment: $equipment, angle: $angle, unilateral: $unilateral, orientation: $orientation, attachment: $attachment, grip: $grip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllowedDiscriminatorsImpl &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            const DeepCollectionEquality().equals(other._angle, _angle) &&
            const DeepCollectionEquality()
                .equals(other._unilateral, _unilateral) &&
            const DeepCollectionEquality()
                .equals(other._orientation, _orientation) &&
            const DeepCollectionEquality()
                .equals(other._attachment, _attachment) &&
            const DeepCollectionEquality().equals(other._grip, _grip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_equipment),
      const DeepCollectionEquality().hash(_angle),
      const DeepCollectionEquality().hash(_unilateral),
      const DeepCollectionEquality().hash(_orientation),
      const DeepCollectionEquality().hash(_attachment),
      const DeepCollectionEquality().hash(_grip));

  /// Create a copy of AllowedDiscriminators
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllowedDiscriminatorsImplCopyWith<_$AllowedDiscriminatorsImpl>
      get copyWith => __$$AllowedDiscriminatorsImplCopyWithImpl<
          _$AllowedDiscriminatorsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllowedDiscriminatorsImplToJson(
      this,
    );
  }
}

abstract class _AllowedDiscriminators implements AllowedDiscriminators {
  const factory _AllowedDiscriminators(
      {final List<String> equipment,
      final List<String> angle,
      final List<String> unilateral,
      final List<String> orientation,
      final List<String> attachment,
      final List<String> grip}) = _$AllowedDiscriminatorsImpl;

  factory _AllowedDiscriminators.fromJson(Map<String, dynamic> json) =
      _$AllowedDiscriminatorsImpl.fromJson;

  @override
  List<String> get equipment;
  @override
  List<String> get angle;
  @override
  List<String> get unilateral;
  @override
  List<String> get orientation;
  @override
  List<String> get attachment;
  @override
  List<String> get grip;

  /// Create a copy of AllowedDiscriminators
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllowedDiscriminatorsImplCopyWith<_$AllowedDiscriminatorsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DenyRule _$DenyRuleFromJson(Map<String, dynamic> json) {
  return _DenyRule.fromJson(json);
}

/// @nodoc
mixin _$DenyRule {
  String? get equipment => throw _privateConstructorUsedError;
  List<String>? get attachment => throw _privateConstructorUsedError;

  /// Serializes this DenyRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DenyRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DenyRuleCopyWith<DenyRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DenyRuleCopyWith<$Res> {
  factory $DenyRuleCopyWith(DenyRule value, $Res Function(DenyRule) then) =
      _$DenyRuleCopyWithImpl<$Res, DenyRule>;
  @useResult
  $Res call({String? equipment, List<String>? attachment});
}

/// @nodoc
class _$DenyRuleCopyWithImpl<$Res, $Val extends DenyRule>
    implements $DenyRuleCopyWith<$Res> {
  _$DenyRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DenyRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_value.copyWith(
      equipment: freezed == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DenyRuleImplCopyWith<$Res>
    implements $DenyRuleCopyWith<$Res> {
  factory _$$DenyRuleImplCopyWith(
          _$DenyRuleImpl value, $Res Function(_$DenyRuleImpl) then) =
      __$$DenyRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? equipment, List<String>? attachment});
}

/// @nodoc
class __$$DenyRuleImplCopyWithImpl<$Res>
    extends _$DenyRuleCopyWithImpl<$Res, _$DenyRuleImpl>
    implements _$$DenyRuleImplCopyWith<$Res> {
  __$$DenyRuleImplCopyWithImpl(
      _$DenyRuleImpl _value, $Res Function(_$DenyRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of DenyRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_$DenyRuleImpl(
      equipment: freezed == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value._attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DenyRuleImpl implements _DenyRule {
  const _$DenyRuleImpl({this.equipment, final List<String>? attachment})
      : _attachment = attachment;

  factory _$DenyRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DenyRuleImplFromJson(json);

  @override
  final String? equipment;
  final List<String>? _attachment;
  @override
  List<String>? get attachment {
    final value = _attachment;
    if (value == null) return null;
    if (_attachment is EqualUnmodifiableListView) return _attachment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DenyRule(equipment: $equipment, attachment: $attachment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DenyRuleImpl &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other._attachment, _attachment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, equipment, const DeepCollectionEquality().hash(_attachment));

  /// Create a copy of DenyRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DenyRuleImplCopyWith<_$DenyRuleImpl> get copyWith =>
      __$$DenyRuleImplCopyWithImpl<_$DenyRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DenyRuleImplToJson(
      this,
    );
  }
}

abstract class _DenyRule implements DenyRule {
  const factory _DenyRule(
      {final String? equipment,
      final List<String>? attachment}) = _$DenyRuleImpl;

  factory _DenyRule.fromJson(Map<String, dynamic> json) =
      _$DenyRuleImpl.fromJson;

  @override
  String? get equipment;
  @override
  List<String>? get attachment;

  /// Create a copy of DenyRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DenyRuleImplCopyWith<_$DenyRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NamingRule _$NamingRuleFromJson(Map<String, dynamic> json) {
  return _NamingRule.fromJson(json);
}

/// @nodoc
mixin _$NamingRule {
// ignore: invalid_annotation_target
  @JsonKey(name: 'if')
  Map<String, String> get ifCondition => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this NamingRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NamingRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NamingRuleCopyWith<NamingRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamingRuleCopyWith<$Res> {
  factory $NamingRuleCopyWith(
          NamingRule value, $Res Function(NamingRule) then) =
      _$NamingRuleCopyWithImpl<$Res, NamingRule>;
  @useResult
  $Res call(
      {@JsonKey(name: 'if') Map<String, String> ifCondition, String name});
}

/// @nodoc
class _$NamingRuleCopyWithImpl<$Res, $Val extends NamingRule>
    implements $NamingRuleCopyWith<$Res> {
  _$NamingRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NamingRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ifCondition = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      ifCondition: null == ifCondition
          ? _value.ifCondition
          : ifCondition // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NamingRuleImplCopyWith<$Res>
    implements $NamingRuleCopyWith<$Res> {
  factory _$$NamingRuleImplCopyWith(
          _$NamingRuleImpl value, $Res Function(_$NamingRuleImpl) then) =
      __$$NamingRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'if') Map<String, String> ifCondition, String name});
}

/// @nodoc
class __$$NamingRuleImplCopyWithImpl<$Res>
    extends _$NamingRuleCopyWithImpl<$Res, _$NamingRuleImpl>
    implements _$$NamingRuleImplCopyWith<$Res> {
  __$$NamingRuleImplCopyWithImpl(
      _$NamingRuleImpl _value, $Res Function(_$NamingRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of NamingRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ifCondition = null,
    Object? name = null,
  }) {
    return _then(_$NamingRuleImpl(
      ifCondition: null == ifCondition
          ? _value._ifCondition
          : ifCondition // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamingRuleImpl implements _NamingRule {
  const _$NamingRuleImpl(
      {@JsonKey(name: 'if') required final Map<String, String> ifCondition,
      required this.name})
      : _ifCondition = ifCondition;

  factory _$NamingRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamingRuleImplFromJson(json);

// ignore: invalid_annotation_target
  final Map<String, String> _ifCondition;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'if')
  Map<String, String> get ifCondition {
    if (_ifCondition is EqualUnmodifiableMapView) return _ifCondition;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ifCondition);
  }

  @override
  final String name;

  @override
  String toString() {
    return 'NamingRule(ifCondition: $ifCondition, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamingRuleImpl &&
            const DeepCollectionEquality()
                .equals(other._ifCondition, _ifCondition) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_ifCondition), name);

  /// Create a copy of NamingRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NamingRuleImplCopyWith<_$NamingRuleImpl> get copyWith =>
      __$$NamingRuleImplCopyWithImpl<_$NamingRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamingRuleImplToJson(
      this,
    );
  }
}

abstract class _NamingRule implements NamingRule {
  const factory _NamingRule(
      {@JsonKey(name: 'if') required final Map<String, String> ifCondition,
      required final String name}) = _$NamingRuleImpl;

  factory _NamingRule.fromJson(Map<String, dynamic> json) =
      _$NamingRuleImpl.fromJson;

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'if')
  Map<String, String> get ifCondition;
  @override
  String get name;

  /// Create a copy of NamingRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NamingRuleImplCopyWith<_$NamingRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
