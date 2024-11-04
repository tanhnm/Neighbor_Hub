// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DriverState {
  List<Map<String, dynamic>> get drivers => throw _privateConstructorUsedError;
  List<dynamic> get registrationDrivers => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverStateCopyWith<DriverState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverStateCopyWith<$Res> {
  factory $DriverStateCopyWith(
          DriverState value, $Res Function(DriverState) then) =
      _$DriverStateCopyWithImpl<$Res, DriverState>;
  @useResult
  $Res call(
      {List<Map<String, dynamic>> drivers,
      List<dynamic> registrationDrivers,
      String? errorMessage,
      bool isLoading});
}

/// @nodoc
class _$DriverStateCopyWithImpl<$Res, $Val extends DriverState>
    implements $DriverStateCopyWith<$Res> {
  _$DriverStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drivers = null,
    Object? registrationDrivers = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      drivers: null == drivers
          ? _value.drivers
          : drivers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      registrationDrivers: null == registrationDrivers
          ? _value.registrationDrivers
          : registrationDrivers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverStateImplCopyWith<$Res>
    implements $DriverStateCopyWith<$Res> {
  factory _$$DriverStateImplCopyWith(
          _$DriverStateImpl value, $Res Function(_$DriverStateImpl) then) =
      __$$DriverStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Map<String, dynamic>> drivers,
      List<dynamic> registrationDrivers,
      String? errorMessage,
      bool isLoading});
}

/// @nodoc
class __$$DriverStateImplCopyWithImpl<$Res>
    extends _$DriverStateCopyWithImpl<$Res, _$DriverStateImpl>
    implements _$$DriverStateImplCopyWith<$Res> {
  __$$DriverStateImplCopyWithImpl(
      _$DriverStateImpl _value, $Res Function(_$DriverStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drivers = null,
    Object? registrationDrivers = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$DriverStateImpl(
      drivers: null == drivers
          ? _value._drivers
          : drivers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      registrationDrivers: null == registrationDrivers
          ? _value._registrationDrivers
          : registrationDrivers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DriverStateImpl implements _DriverState {
  const _$DriverStateImpl(
      {required final List<Map<String, dynamic>> drivers,
      required final List<dynamic> registrationDrivers,
      this.errorMessage,
      this.isLoading = false})
      : _drivers = drivers,
        _registrationDrivers = registrationDrivers;

  final List<Map<String, dynamic>> _drivers;
  @override
  List<Map<String, dynamic>> get drivers {
    if (_drivers is EqualUnmodifiableListView) return _drivers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drivers);
  }

  final List<dynamic> _registrationDrivers;
  @override
  List<dynamic> get registrationDrivers {
    if (_registrationDrivers is EqualUnmodifiableListView)
      return _registrationDrivers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_registrationDrivers);
  }

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'DriverState(drivers: $drivers, registrationDrivers: $registrationDrivers, errorMessage: $errorMessage, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverStateImpl &&
            const DeepCollectionEquality().equals(other._drivers, _drivers) &&
            const DeepCollectionEquality()
                .equals(other._registrationDrivers, _registrationDrivers) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_drivers),
      const DeepCollectionEquality().hash(_registrationDrivers),
      errorMessage,
      isLoading);

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverStateImplCopyWith<_$DriverStateImpl> get copyWith =>
      __$$DriverStateImplCopyWithImpl<_$DriverStateImpl>(this, _$identity);
}

abstract class _DriverState implements DriverState {
  const factory _DriverState(
      {required final List<Map<String, dynamic>> drivers,
      required final List<dynamic> registrationDrivers,
      final String? errorMessage,
      final bool isLoading}) = _$DriverStateImpl;

  @override
  List<Map<String, dynamic>> get drivers;
  @override
  List<dynamic> get registrationDrivers;
  @override
  String? get errorMessage;
  @override
  bool get isLoading;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverStateImplCopyWith<_$DriverStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
