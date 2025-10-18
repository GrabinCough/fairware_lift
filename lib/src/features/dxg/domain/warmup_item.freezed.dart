// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warmup_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarmupItem _$WarmupItemFromJson(Map<String, dynamic> json) {
  return _WarmupItem.fromJson(json);
}

/// @nodoc
mixin _$WarmupItem {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get pattern => throw _privateConstructorUsedError;
  String get modality =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;

  /// Serializes this WarmupItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WarmupItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WarmupItemCopyWith<WarmupItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarmupItemCopyWith<$Res> {
  factory $WarmupItemCopyWith(
          WarmupItem value, $Res Function(WarmupItem) then) =
      _$WarmupItemCopyWithImpl<$Res, WarmupItem>;
  @useResult
  $Res call(
      {String id,
      String type,
      String region,
      String pattern,
      String modality,
      @JsonKey(name: 'display_name') String displayName});
}

/// @nodoc
class _$WarmupItemCopyWithImpl<$Res, $Val extends WarmupItem>
    implements $WarmupItemCopyWith<$Res> {
  _$WarmupItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WarmupItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? region = null,
    Object? pattern = null,
    Object? modality = null,
    Object? displayName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      modality: null == modality
          ? _value.modality
          : modality // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarmupItemImplCopyWith<$Res>
    implements $WarmupItemCopyWith<$Res> {
  factory _$$WarmupItemImplCopyWith(
          _$WarmupItemImpl value, $Res Function(_$WarmupItemImpl) then) =
      __$$WarmupItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String region,
      String pattern,
      String modality,
      @JsonKey(name: 'display_name') String displayName});
}

/// @nodoc
class __$$WarmupItemImplCopyWithImpl<$Res>
    extends _$WarmupItemCopyWithImpl<$Res, _$WarmupItemImpl>
    implements _$$WarmupItemImplCopyWith<$Res> {
  __$$WarmupItemImplCopyWithImpl(
      _$WarmupItemImpl _value, $Res Function(_$WarmupItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WarmupItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? region = null,
    Object? pattern = null,
    Object? modality = null,
    Object? displayName = null,
  }) {
    return _then(_$WarmupItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      modality: null == modality
          ? _value.modality
          : modality // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarmupItemImpl implements _WarmupItem {
  const _$WarmupItemImpl(
      {required this.id,
      required this.type,
      required this.region,
      required this.pattern,
      required this.modality,
      @JsonKey(name: 'display_name') required this.displayName});

  factory _$WarmupItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WarmupItemImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String region;
  @override
  final String pattern;
  @override
  final String modality;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'display_name')
  final String displayName;

  @override
  String toString() {
    return 'WarmupItem(id: $id, type: $type, region: $region, pattern: $pattern, modality: $modality, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarmupItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.modality, modality) ||
                other.modality == modality) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, region, pattern, modality, displayName);

  /// Create a copy of WarmupItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WarmupItemImplCopyWith<_$WarmupItemImpl> get copyWith =>
      __$$WarmupItemImplCopyWithImpl<_$WarmupItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarmupItemImplToJson(
      this,
    );
  }
}

abstract class _WarmupItem implements WarmupItem {
  const factory _WarmupItem(
          {required final String id,
          required final String type,
          required final String region,
          required final String pattern,
          required final String modality,
          @JsonKey(name: 'display_name') required final String displayName}) =
      _$WarmupItemImpl;

  factory _WarmupItem.fromJson(Map<String, dynamic> json) =
      _$WarmupItemImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get region;
  @override
  String get pattern;
  @override
  String get modality; // ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'display_name')
  String get displayName;

  /// Create a copy of WarmupItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WarmupItemImplCopyWith<_$WarmupItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
