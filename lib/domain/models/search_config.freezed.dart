// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchConfig {
  String get handle => throw _privateConstructorUsedError;
  List<String> get previousHandles => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Create a copy of SearchConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchConfigCopyWith<SearchConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchConfigCopyWith<$Res> {
  factory $SearchConfigCopyWith(
          SearchConfig value, $Res Function(SearchConfig) then) =
      _$SearchConfigCopyWithImpl<$Res, SearchConfig>;
  @useResult
  $Res call(
      {String handle,
      List<String> previousHandles,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$SearchConfigCopyWithImpl<$Res, $Val extends SearchConfig>
    implements $SearchConfigCopyWith<$Res> {
  _$SearchConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? previousHandles = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      previousHandles: null == previousHandles
          ? _value.previousHandles
          : previousHandles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$searchConfigImplCopyWith<$Res>
    implements $SearchConfigCopyWith<$Res> {
  factory _$$searchConfigImplCopyWith(
          _$searchConfigImpl value, $Res Function(_$searchConfigImpl) then) =
      __$$searchConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String handle,
      List<String> previousHandles,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$searchConfigImplCopyWithImpl<$Res>
    extends _$SearchConfigCopyWithImpl<$Res, _$searchConfigImpl>
    implements _$$searchConfigImplCopyWith<$Res> {
  __$$searchConfigImplCopyWithImpl(
      _$searchConfigImpl _value, $Res Function(_$searchConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handle = null,
    Object? previousHandles = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$searchConfigImpl(
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as String,
      previousHandles: null == previousHandles
          ? _value._previousHandles
          : previousHandles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$searchConfigImpl implements _searchConfig {
  const _$searchConfigImpl(
      {required this.handle,
      required final List<String> previousHandles,
      required this.startDate,
      required this.endDate})
      : _previousHandles = previousHandles;

  @override
  final String handle;
  final List<String> _previousHandles;
  @override
  List<String> get previousHandles {
    if (_previousHandles is EqualUnmodifiableListView) return _previousHandles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousHandles);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'SearchConfig(handle: $handle, previousHandles: $previousHandles, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$searchConfigImpl &&
            (identical(other.handle, handle) || other.handle == handle) &&
            const DeepCollectionEquality()
                .equals(other._previousHandles, _previousHandles) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      handle,
      const DeepCollectionEquality().hash(_previousHandles),
      startDate,
      endDate);

  /// Create a copy of SearchConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$searchConfigImplCopyWith<_$searchConfigImpl> get copyWith =>
      __$$searchConfigImplCopyWithImpl<_$searchConfigImpl>(this, _$identity);
}

abstract class _searchConfig implements SearchConfig {
  const factory _searchConfig(
      {required final String handle,
      required final List<String> previousHandles,
      required final DateTime startDate,
      required final DateTime endDate}) = _$searchConfigImpl;

  @override
  String get handle;
  @override
  List<String> get previousHandles;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of SearchConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$searchConfigImplCopyWith<_$searchConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
