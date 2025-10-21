// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionItem {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
    required TResult Function(String id, List<SessionExercise> exercises)
        superset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult? Function(String id, List<SessionExercise> exercises)? superset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult Function(String id, List<SessionExercise> exercises)? superset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
    required TResult Function(SessionSuperset value) superset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
    TResult? Function(SessionSuperset value)? superset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
    TResult Function(SessionSuperset value)? superset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionItemCopyWith<SessionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionItemCopyWith<$Res> {
  factory $SessionItemCopyWith(
          SessionItem value, $Res Function(SessionItem) then) =
      _$SessionItemCopyWithImpl<$Res, SessionItem>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SessionItemCopyWithImpl<$Res, $Val extends SessionItem>
    implements $SessionItemCopyWith<$Res> {
  _$SessionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionExerciseImplCopyWith<$Res>
    implements $SessionItemCopyWith<$Res> {
  factory _$$SessionExerciseImplCopyWith(_$SessionExerciseImpl value,
          $Res Function(_$SessionExerciseImpl) then) =
      __$$SessionExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? slug,
      String exerciseHash,
      String displayName,
      Prescription prescription,
      Map<String, dynamic> variation,
      String? defaultSetType,
      Info? info,
      List<LoggedSet> loggedSets,
      bool isCurrent,
      bool unmapped});
}

/// @nodoc
class __$$SessionExerciseImplCopyWithImpl<$Res>
    extends _$SessionItemCopyWithImpl<$Res, _$SessionExerciseImpl>
    implements _$$SessionExerciseImplCopyWith<$Res> {
  __$$SessionExerciseImplCopyWithImpl(
      _$SessionExerciseImpl _value, $Res Function(_$SessionExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = freezed,
    Object? exerciseHash = null,
    Object? displayName = null,
    Object? prescription = null,
    Object? variation = null,
    Object? defaultSetType = freezed,
    Object? info = freezed,
    Object? loggedSets = null,
    Object? isCurrent = null,
    Object? unmapped = null,
  }) {
    return _then(_$SessionExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      exerciseHash: null == exerciseHash
          ? _value.exerciseHash
          : exerciseHash // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      prescription: null == prescription
          ? _value.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as Prescription,
      variation: null == variation
          ? _value._variation
          : variation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      defaultSetType: freezed == defaultSetType
          ? _value.defaultSetType
          : defaultSetType // ignore: cast_nullable_to_non_nullable
              as String?,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as Info?,
      loggedSets: null == loggedSets
          ? _value._loggedSets
          : loggedSets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      unmapped: null == unmapped
          ? _value.unmapped
          : unmapped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SessionExerciseImpl implements SessionExercise {
  const _$SessionExerciseImpl(
      {required this.id,
      this.slug,
      required this.exerciseHash,
      required this.displayName,
      required this.prescription,
      required final Map<String, dynamic> variation,
      this.defaultSetType,
      this.info,
      final List<LoggedSet> loggedSets = const [],
      this.isCurrent = false,
      this.unmapped = false})
      : _variation = variation,
        _loggedSets = loggedSets;

  @override
  final String id;
  @override
  final String? slug;
  @override
  final String exerciseHash;
  @override
  final String displayName;
  @override
  final Prescription prescription;
  final Map<String, dynamic> _variation;
  @override
  Map<String, dynamic> get variation {
    if (_variation is EqualUnmodifiableMapView) return _variation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_variation);
  }

  @override
  final String? defaultSetType;
// NEW
  @override
  final Info? info;
  final List<LoggedSet> _loggedSets;
  @override
  @JsonKey()
  List<LoggedSet> get loggedSets {
    if (_loggedSets is EqualUnmodifiableListView) return _loggedSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loggedSets);
  }

  @override
  @JsonKey()
  final bool isCurrent;
  @override
  @JsonKey()
  final bool unmapped;

  @override
  String toString() {
    return 'SessionItem.exercise(id: $id, slug: $slug, exerciseHash: $exerciseHash, displayName: $displayName, prescription: $prescription, variation: $variation, defaultSetType: $defaultSetType, info: $info, loggedSets: $loggedSets, isCurrent: $isCurrent, unmapped: $unmapped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.exerciseHash, exerciseHash) ||
                other.exerciseHash == exerciseHash) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            const DeepCollectionEquality()
                .equals(other._variation, _variation) &&
            (identical(other.defaultSetType, defaultSetType) ||
                other.defaultSetType == defaultSetType) &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality()
                .equals(other._loggedSets, _loggedSets) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.unmapped, unmapped) ||
                other.unmapped == unmapped));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      slug,
      exerciseHash,
      displayName,
      prescription,
      const DeepCollectionEquality().hash(_variation),
      defaultSetType,
      info,
      const DeepCollectionEquality().hash(_loggedSets),
      isCurrent,
      unmapped);

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionExerciseImplCopyWith<_$SessionExerciseImpl> get copyWith =>
      __$$SessionExerciseImplCopyWithImpl<_$SessionExerciseImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
    required TResult Function(String id, List<SessionExercise> exercises)
        superset,
  }) {
    return exercise(id, slug, exerciseHash, displayName, prescription,
        variation, defaultSetType, info, loggedSets, isCurrent, unmapped);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult? Function(String id, List<SessionExercise> exercises)? superset,
  }) {
    return exercise?.call(id, slug, exerciseHash, displayName, prescription,
        variation, defaultSetType, info, loggedSets, isCurrent, unmapped);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult Function(String id, List<SessionExercise> exercises)? superset,
    required TResult orElse(),
  }) {
    if (exercise != null) {
      return exercise(id, slug, exerciseHash, displayName, prescription,
          variation, defaultSetType, info, loggedSets, isCurrent, unmapped);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
    required TResult Function(SessionSuperset value) superset,
  }) {
    return exercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
    TResult? Function(SessionSuperset value)? superset,
  }) {
    return exercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
    TResult Function(SessionSuperset value)? superset,
    required TResult orElse(),
  }) {
    if (exercise != null) {
      return exercise(this);
    }
    return orElse();
  }
}

abstract class SessionExercise implements SessionItem {
  const factory SessionExercise(
      {required final String id,
      final String? slug,
      required final String exerciseHash,
      required final String displayName,
      required final Prescription prescription,
      required final Map<String, dynamic> variation,
      final String? defaultSetType,
      final Info? info,
      final List<LoggedSet> loggedSets,
      final bool isCurrent,
      final bool unmapped}) = _$SessionExerciseImpl;

  @override
  String get id;
  String? get slug;
  String get exerciseHash;
  String get displayName;
  Prescription get prescription;
  Map<String, dynamic> get variation;
  String? get defaultSetType; // NEW
  Info? get info;
  List<LoggedSet> get loggedSets;
  bool get isCurrent;
  bool get unmapped;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionExerciseImplCopyWith<_$SessionExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionWarmupItemImplCopyWith<$Res>
    implements $SessionItemCopyWith<$Res> {
  factory _$$SessionWarmupItemImplCopyWith(_$SessionWarmupItemImpl value,
          $Res Function(_$SessionWarmupItemImpl) then) =
      __$$SessionWarmupItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, WarmupItem item, Map<String, String> selectedParameters});

  $WarmupItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$SessionWarmupItemImplCopyWithImpl<$Res>
    extends _$SessionItemCopyWithImpl<$Res, _$SessionWarmupItemImpl>
    implements _$$SessionWarmupItemImplCopyWith<$Res> {
  __$$SessionWarmupItemImplCopyWithImpl(_$SessionWarmupItemImpl _value,
      $Res Function(_$SessionWarmupItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? item = null,
    Object? selectedParameters = null,
  }) {
    return _then(_$SessionWarmupItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as WarmupItem,
      selectedParameters: null == selectedParameters
          ? _value._selectedParameters
          : selectedParameters // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WarmupItemCopyWith<$Res> get item {
    return $WarmupItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$SessionWarmupItemImpl implements SessionWarmupItem {
  const _$SessionWarmupItemImpl(
      {required this.id,
      required this.item,
      required final Map<String, String> selectedParameters})
      : _selectedParameters = selectedParameters;

  @override
  final String id;
  @override
  final WarmupItem item;
  final Map<String, String> _selectedParameters;
  @override
  Map<String, String> get selectedParameters {
    if (_selectedParameters is EqualUnmodifiableMapView)
      return _selectedParameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedParameters);
  }

  @override
  String toString() {
    return 'SessionItem.warmup(id: $id, item: $item, selectedParameters: $selectedParameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionWarmupItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.item, item) || other.item == item) &&
            const DeepCollectionEquality()
                .equals(other._selectedParameters, _selectedParameters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, item,
      const DeepCollectionEquality().hash(_selectedParameters));

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionWarmupItemImplCopyWith<_$SessionWarmupItemImpl> get copyWith =>
      __$$SessionWarmupItemImplCopyWithImpl<_$SessionWarmupItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
    required TResult Function(String id, List<SessionExercise> exercises)
        superset,
  }) {
    return warmup(id, item, selectedParameters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult? Function(String id, List<SessionExercise> exercises)? superset,
  }) {
    return warmup?.call(id, item, selectedParameters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult Function(String id, List<SessionExercise> exercises)? superset,
    required TResult orElse(),
  }) {
    if (warmup != null) {
      return warmup(id, item, selectedParameters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
    required TResult Function(SessionSuperset value) superset,
  }) {
    return warmup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
    TResult? Function(SessionSuperset value)? superset,
  }) {
    return warmup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
    TResult Function(SessionSuperset value)? superset,
    required TResult orElse(),
  }) {
    if (warmup != null) {
      return warmup(this);
    }
    return orElse();
  }
}

abstract class SessionWarmupItem implements SessionItem {
  const factory SessionWarmupItem(
          {required final String id,
          required final WarmupItem item,
          required final Map<String, String> selectedParameters}) =
      _$SessionWarmupItemImpl;

  @override
  String get id;
  WarmupItem get item;
  Map<String, String> get selectedParameters;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionWarmupItemImplCopyWith<_$SessionWarmupItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionSupersetImplCopyWith<$Res>
    implements $SessionItemCopyWith<$Res> {
  factory _$$SessionSupersetImplCopyWith(_$SessionSupersetImpl value,
          $Res Function(_$SessionSupersetImpl) then) =
      __$$SessionSupersetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<SessionExercise> exercises});
}

/// @nodoc
class __$$SessionSupersetImplCopyWithImpl<$Res>
    extends _$SessionItemCopyWithImpl<$Res, _$SessionSupersetImpl>
    implements _$$SessionSupersetImplCopyWith<$Res> {
  __$$SessionSupersetImplCopyWithImpl(
      _$SessionSupersetImpl _value, $Res Function(_$SessionSupersetImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exercises = null,
  }) {
    return _then(_$SessionSupersetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<SessionExercise>,
    ));
  }
}

/// @nodoc

class _$SessionSupersetImpl implements SessionSuperset {
  const _$SessionSupersetImpl(
      {required this.id, final List<SessionExercise> exercises = const []})
      : _exercises = exercises;

  @override
  final String id;
  final List<SessionExercise> _exercises;
  @override
  @JsonKey()
  List<SessionExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'SessionItem.superset(id: $id, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionSupersetImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_exercises));

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionSupersetImplCopyWith<_$SessionSupersetImpl> get copyWith =>
      __$$SessionSupersetImplCopyWithImpl<_$SessionSupersetImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
    required TResult Function(String id, List<SessionExercise> exercises)
        superset,
  }) {
    return superset(id, exercises);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult? Function(String id, List<SessionExercise> exercises)? superset,
  }) {
    return superset?.call(id, exercises);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String? slug,
            String exerciseHash,
            String displayName,
            Prescription prescription,
            Map<String, dynamic> variation,
            String? defaultSetType,
            Info? info,
            List<LoggedSet> loggedSets,
            bool isCurrent,
            bool unmapped)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    TResult Function(String id, List<SessionExercise> exercises)? superset,
    required TResult orElse(),
  }) {
    if (superset != null) {
      return superset(id, exercises);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
    required TResult Function(SessionSuperset value) superset,
  }) {
    return superset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
    TResult? Function(SessionSuperset value)? superset,
  }) {
    return superset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
    TResult Function(SessionSuperset value)? superset,
    required TResult orElse(),
  }) {
    if (superset != null) {
      return superset(this);
    }
    return orElse();
  }
}

abstract class SessionSuperset implements SessionItem {
  const factory SessionSuperset(
      {required final String id,
      final List<SessionExercise> exercises}) = _$SessionSupersetImpl;

  @override
  String get id;
  List<SessionExercise> get exercises;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionSupersetImplCopyWith<_$SessionSupersetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
