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
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
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
      String slug,
      String displayName,
      Map<String, String> discriminators,
      String target,
      List<LoggedSet> loggedSets,
      bool isCurrent});
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
    Object? slug = null,
    Object? displayName = null,
    Object? discriminators = null,
    Object? target = null,
    Object? loggedSets = null,
    Object? isCurrent = null,
  }) {
    return _then(_$SessionExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      discriminators: null == discriminators
          ? _value._discriminators
          : discriminators // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      loggedSets: null == loggedSets
          ? _value._loggedSets
          : loggedSets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SessionExerciseImpl implements SessionExercise {
  const _$SessionExerciseImpl(
      {required this.id,
      required this.slug,
      required this.displayName,
      required final Map<String, String> discriminators,
      required this.target,
      final List<LoggedSet> loggedSets = const [],
      this.isCurrent = false})
      : _discriminators = discriminators,
        _loggedSets = loggedSets;

  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;
  final Map<String, String> _discriminators;
  @override
  Map<String, String> get discriminators {
    if (_discriminators is EqualUnmodifiableMapView) return _discriminators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_discriminators);
  }

  @override
  final String target;
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
  String toString() {
    return 'SessionItem.exercise(id: $id, slug: $slug, displayName: $displayName, discriminators: $discriminators, target: $target, loggedSets: $loggedSets, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            const DeepCollectionEquality()
                .equals(other._discriminators, _discriminators) &&
            (identical(other.target, target) || other.target == target) &&
            const DeepCollectionEquality()
                .equals(other._loggedSets, _loggedSets) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      slug,
      displayName,
      const DeepCollectionEquality().hash(_discriminators),
      target,
      const DeepCollectionEquality().hash(_loggedSets),
      isCurrent);

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
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
  }) {
    return exercise(
        id, slug, displayName, discriminators, target, loggedSets, isCurrent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
  }) {
    return exercise?.call(
        id, slug, displayName, discriminators, target, loggedSets, isCurrent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
    required TResult orElse(),
  }) {
    if (exercise != null) {
      return exercise(
          id, slug, displayName, discriminators, target, loggedSets, isCurrent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionExercise value) exercise,
    required TResult Function(SessionWarmupItem value) warmup,
  }) {
    return exercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
  }) {
    return exercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
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
      required final String slug,
      required final String displayName,
      required final Map<String, String> discriminators,
      required final String target,
      final List<LoggedSet> loggedSets,
      final bool isCurrent}) = _$SessionExerciseImpl;

  @override
  String get id;
  String get slug;
  String get displayName;
  Map<String, String> get discriminators;
  String get target;
  List<LoggedSet> get loggedSets;
  bool get isCurrent;

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
// --- NEW ---
// Stores the user's selections, e.g., {'Grip': 'Wide'}
  final Map<String, String> _selectedParameters;
// --- NEW ---
// Stores the user's selections, e.g., {'Grip': 'Wide'}
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
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)
        exercise,
    required TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)
        warmup,
  }) {
    return warmup(id, item, selectedParameters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult? Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
  }) {
    return warmup?.call(id, item, selectedParameters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String slug,
            String displayName,
            Map<String, String> discriminators,
            String target,
            List<LoggedSet> loggedSets,
            bool isCurrent)?
        exercise,
    TResult Function(
            String id, WarmupItem item, Map<String, String> selectedParameters)?
        warmup,
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
  }) {
    return warmup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionExercise value)? exercise,
    TResult? Function(SessionWarmupItem value)? warmup,
  }) {
    return warmup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionExercise value)? exercise,
    TResult Function(SessionWarmupItem value)? warmup,
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
  WarmupItem get item; // --- NEW ---
// Stores the user's selections, e.g., {'Grip': 'Wide'}
  Map<String, String> get selectedParameters;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionWarmupItemImplCopyWith<_$SessionWarmupItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
