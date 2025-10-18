// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dxg_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GeneratedExerciseResult {
  String get displayName => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  Map<String, String> get discriminators => throw _privateConstructorUsedError;
  String get familyId => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedExerciseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedExerciseResultCopyWith<GeneratedExerciseResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedExerciseResultCopyWith<$Res> {
  factory $GeneratedExerciseResultCopyWith(GeneratedExerciseResult value,
          $Res Function(GeneratedExerciseResult) then) =
      _$GeneratedExerciseResultCopyWithImpl<$Res, GeneratedExerciseResult>;
  @useResult
  $Res call(
      {String displayName,
      String slug,
      Map<String, String> discriminators,
      String familyId});
}

/// @nodoc
class _$GeneratedExerciseResultCopyWithImpl<$Res,
        $Val extends GeneratedExerciseResult>
    implements $GeneratedExerciseResultCopyWith<$Res> {
  _$GeneratedExerciseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedExerciseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? slug = null,
    Object? discriminators = null,
    Object? familyId = null,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      discriminators: null == discriminators
          ? _value.discriminators
          : discriminators // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneratedExerciseResultImplCopyWith<$Res>
    implements $GeneratedExerciseResultCopyWith<$Res> {
  factory _$$GeneratedExerciseResultImplCopyWith(
          _$GeneratedExerciseResultImpl value,
          $Res Function(_$GeneratedExerciseResultImpl) then) =
      __$$GeneratedExerciseResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String displayName,
      String slug,
      Map<String, String> discriminators,
      String familyId});
}

/// @nodoc
class __$$GeneratedExerciseResultImplCopyWithImpl<$Res>
    extends _$GeneratedExerciseResultCopyWithImpl<$Res,
        _$GeneratedExerciseResultImpl>
    implements _$$GeneratedExerciseResultImplCopyWith<$Res> {
  __$$GeneratedExerciseResultImplCopyWithImpl(
      _$GeneratedExerciseResultImpl _value,
      $Res Function(_$GeneratedExerciseResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratedExerciseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? slug = null,
    Object? discriminators = null,
    Object? familyId = null,
  }) {
    return _then(_$GeneratedExerciseResultImpl(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      discriminators: null == discriminators
          ? _value._discriminators
          : discriminators // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GeneratedExerciseResultImpl implements _GeneratedExerciseResult {
  const _$GeneratedExerciseResultImpl(
      {required this.displayName,
      required this.slug,
      required final Map<String, String> discriminators,
      required this.familyId})
      : _discriminators = discriminators;

  @override
  final String displayName;
  @override
  final String slug;
  final Map<String, String> _discriminators;
  @override
  Map<String, String> get discriminators {
    if (_discriminators is EqualUnmodifiableMapView) return _discriminators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_discriminators);
  }

  @override
  final String familyId;

  @override
  String toString() {
    return 'GeneratedExerciseResult(displayName: $displayName, slug: $slug, discriminators: $discriminators, familyId: $familyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedExerciseResultImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality()
                .equals(other._discriminators, _discriminators) &&
            (identical(other.familyId, familyId) ||
                other.familyId == familyId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, slug,
      const DeepCollectionEquality().hash(_discriminators), familyId);

  /// Create a copy of GeneratedExerciseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedExerciseResultImplCopyWith<_$GeneratedExerciseResultImpl>
      get copyWith => __$$GeneratedExerciseResultImplCopyWithImpl<
          _$GeneratedExerciseResultImpl>(this, _$identity);
}

abstract class _GeneratedExerciseResult implements GeneratedExerciseResult {
  const factory _GeneratedExerciseResult(
      {required final String displayName,
      required final String slug,
      required final Map<String, String> discriminators,
      required final String familyId}) = _$GeneratedExerciseResultImpl;

  @override
  String get displayName;
  @override
  String get slug;
  @override
  Map<String, String> get discriminators;
  @override
  String get familyId;

  /// Create a copy of GeneratedExerciseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedExerciseResultImplCopyWith<_$GeneratedExerciseResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DXGState {
  /// The master list of all families, loaded once from the seed JSON.
  List<MovementFamily> get allFamilies => throw _privateConstructorUsedError;

  /// The user's currently selected family ID.
  String? get selectedFamilyId => throw _privateConstructorUsedError;

  /// The user's currently selected discriminator values.
  Map<String, String> get selections => throw _privateConstructorUsedError;

  /// The calculated set of valid options for each discriminator field.
  Map<String, Set<String>> get availableOptions =>
      throw _privateConstructorUsedError;

  /// The final, generated canonical exercise if all required fields are selected.
  GeneratedExerciseResult? get canonicalExercise =>
      throw _privateConstructorUsedError;

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DXGStateCopyWith<DXGState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DXGStateCopyWith<$Res> {
  factory $DXGStateCopyWith(DXGState value, $Res Function(DXGState) then) =
      _$DXGStateCopyWithImpl<$Res, DXGState>;
  @useResult
  $Res call(
      {List<MovementFamily> allFamilies,
      String? selectedFamilyId,
      Map<String, String> selections,
      Map<String, Set<String>> availableOptions,
      GeneratedExerciseResult? canonicalExercise});

  $GeneratedExerciseResultCopyWith<$Res>? get canonicalExercise;
}

/// @nodoc
class _$DXGStateCopyWithImpl<$Res, $Val extends DXGState>
    implements $DXGStateCopyWith<$Res> {
  _$DXGStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allFamilies = null,
    Object? selectedFamilyId = freezed,
    Object? selections = null,
    Object? availableOptions = null,
    Object? canonicalExercise = freezed,
  }) {
    return _then(_value.copyWith(
      allFamilies: null == allFamilies
          ? _value.allFamilies
          : allFamilies // ignore: cast_nullable_to_non_nullable
              as List<MovementFamily>,
      selectedFamilyId: freezed == selectedFamilyId
          ? _value.selectedFamilyId
          : selectedFamilyId // ignore: cast_nullable_to_non_nullable
              as String?,
      selections: null == selections
          ? _value.selections
          : selections // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      availableOptions: null == availableOptions
          ? _value.availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<String>>,
      canonicalExercise: freezed == canonicalExercise
          ? _value.canonicalExercise
          : canonicalExercise // ignore: cast_nullable_to_non_nullable
              as GeneratedExerciseResult?,
    ) as $Val);
  }

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeneratedExerciseResultCopyWith<$Res>? get canonicalExercise {
    if (_value.canonicalExercise == null) {
      return null;
    }

    return $GeneratedExerciseResultCopyWith<$Res>(_value.canonicalExercise!,
        (value) {
      return _then(_value.copyWith(canonicalExercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DXGStateImplCopyWith<$Res>
    implements $DXGStateCopyWith<$Res> {
  factory _$$DXGStateImplCopyWith(
          _$DXGStateImpl value, $Res Function(_$DXGStateImpl) then) =
      __$$DXGStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MovementFamily> allFamilies,
      String? selectedFamilyId,
      Map<String, String> selections,
      Map<String, Set<String>> availableOptions,
      GeneratedExerciseResult? canonicalExercise});

  @override
  $GeneratedExerciseResultCopyWith<$Res>? get canonicalExercise;
}

/// @nodoc
class __$$DXGStateImplCopyWithImpl<$Res>
    extends _$DXGStateCopyWithImpl<$Res, _$DXGStateImpl>
    implements _$$DXGStateImplCopyWith<$Res> {
  __$$DXGStateImplCopyWithImpl(
      _$DXGStateImpl _value, $Res Function(_$DXGStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allFamilies = null,
    Object? selectedFamilyId = freezed,
    Object? selections = null,
    Object? availableOptions = null,
    Object? canonicalExercise = freezed,
  }) {
    return _then(_$DXGStateImpl(
      allFamilies: null == allFamilies
          ? _value._allFamilies
          : allFamilies // ignore: cast_nullable_to_non_nullable
              as List<MovementFamily>,
      selectedFamilyId: freezed == selectedFamilyId
          ? _value.selectedFamilyId
          : selectedFamilyId // ignore: cast_nullable_to_non_nullable
              as String?,
      selections: null == selections
          ? _value._selections
          : selections // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      availableOptions: null == availableOptions
          ? _value._availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<String>>,
      canonicalExercise: freezed == canonicalExercise
          ? _value.canonicalExercise
          : canonicalExercise // ignore: cast_nullable_to_non_nullable
              as GeneratedExerciseResult?,
    ));
  }
}

/// @nodoc

class _$DXGStateImpl extends _DXGState {
  const _$DXGStateImpl(
      {required final List<MovementFamily> allFamilies,
      this.selectedFamilyId,
      final Map<String, String> selections = const {},
      final Map<String, Set<String>> availableOptions = const {},
      this.canonicalExercise})
      : _allFamilies = allFamilies,
        _selections = selections,
        _availableOptions = availableOptions,
        super._();

  /// The master list of all families, loaded once from the seed JSON.
  final List<MovementFamily> _allFamilies;

  /// The master list of all families, loaded once from the seed JSON.
  @override
  List<MovementFamily> get allFamilies {
    if (_allFamilies is EqualUnmodifiableListView) return _allFamilies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allFamilies);
  }

  /// The user's currently selected family ID.
  @override
  final String? selectedFamilyId;

  /// The user's currently selected discriminator values.
  final Map<String, String> _selections;

  /// The user's currently selected discriminator values.
  @override
  @JsonKey()
  Map<String, String> get selections {
    if (_selections is EqualUnmodifiableMapView) return _selections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selections);
  }

  /// The calculated set of valid options for each discriminator field.
  final Map<String, Set<String>> _availableOptions;

  /// The calculated set of valid options for each discriminator field.
  @override
  @JsonKey()
  Map<String, Set<String>> get availableOptions {
    if (_availableOptions is EqualUnmodifiableMapView) return _availableOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableOptions);
  }

  /// The final, generated canonical exercise if all required fields are selected.
  @override
  final GeneratedExerciseResult? canonicalExercise;

  @override
  String toString() {
    return 'DXGState(allFamilies: $allFamilies, selectedFamilyId: $selectedFamilyId, selections: $selections, availableOptions: $availableOptions, canonicalExercise: $canonicalExercise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DXGStateImpl &&
            const DeepCollectionEquality()
                .equals(other._allFamilies, _allFamilies) &&
            (identical(other.selectedFamilyId, selectedFamilyId) ||
                other.selectedFamilyId == selectedFamilyId) &&
            const DeepCollectionEquality()
                .equals(other._selections, _selections) &&
            const DeepCollectionEquality()
                .equals(other._availableOptions, _availableOptions) &&
            (identical(other.canonicalExercise, canonicalExercise) ||
                other.canonicalExercise == canonicalExercise));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allFamilies),
      selectedFamilyId,
      const DeepCollectionEquality().hash(_selections),
      const DeepCollectionEquality().hash(_availableOptions),
      canonicalExercise);

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DXGStateImplCopyWith<_$DXGStateImpl> get copyWith =>
      __$$DXGStateImplCopyWithImpl<_$DXGStateImpl>(this, _$identity);
}

abstract class _DXGState extends DXGState {
  const factory _DXGState(
      {required final List<MovementFamily> allFamilies,
      final String? selectedFamilyId,
      final Map<String, String> selections,
      final Map<String, Set<String>> availableOptions,
      final GeneratedExerciseResult? canonicalExercise}) = _$DXGStateImpl;
  const _DXGState._() : super._();

  /// The master list of all families, loaded once from the seed JSON.
  @override
  List<MovementFamily> get allFamilies;

  /// The user's currently selected family ID.
  @override
  String? get selectedFamilyId;

  /// The user's currently selected discriminator values.
  @override
  Map<String, String> get selections;

  /// The calculated set of valid options for each discriminator field.
  @override
  Map<String, Set<String>> get availableOptions;

  /// The final, generated canonical exercise if all required fields are selected.
  @override
  GeneratedExerciseResult? get canonicalExercise;

  /// Create a copy of DXGState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DXGStateImplCopyWith<_$DXGStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
