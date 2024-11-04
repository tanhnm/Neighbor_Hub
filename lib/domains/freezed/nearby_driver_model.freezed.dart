// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_driver_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NearbyDriverModel _$NearbyDriverModelFromJson(Map<String, dynamic> json) {
  return _NearbyDriverModel.fromJson(json);
}

/// @nodoc
mixin _$NearbyDriverModel {
  int get registrationId => throw _privateConstructorUsedError;
  DriverModel get driver => throw _privateConstructorUsedError;

  /// Serializes this NearbyDriverModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NearbyDriverModelCopyWith<NearbyDriverModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyDriverModelCopyWith<$Res> {
  factory $NearbyDriverModelCopyWith(
          NearbyDriverModel value, $Res Function(NearbyDriverModel) then) =
      _$NearbyDriverModelCopyWithImpl<$Res, NearbyDriverModel>;
  @useResult
  $Res call({int registrationId, DriverModel driver});

  $DriverModelCopyWith<$Res> get driver;
}

/// @nodoc
class _$NearbyDriverModelCopyWithImpl<$Res, $Val extends NearbyDriverModel>
    implements $NearbyDriverModelCopyWith<$Res> {
  _$NearbyDriverModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationId = null,
    Object? driver = null,
  }) {
    return _then(_value.copyWith(
      registrationId: null == registrationId
          ? _value.registrationId
          : registrationId // ignore: cast_nullable_to_non_nullable
              as int,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverModel,
    ) as $Val);
  }

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverModelCopyWith<$Res> get driver {
    return $DriverModelCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NearbyDriverModelImplCopyWith<$Res>
    implements $NearbyDriverModelCopyWith<$Res> {
  factory _$$NearbyDriverModelImplCopyWith(_$NearbyDriverModelImpl value,
          $Res Function(_$NearbyDriverModelImpl) then) =
      __$$NearbyDriverModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int registrationId, DriverModel driver});

  @override
  $DriverModelCopyWith<$Res> get driver;
}

/// @nodoc
class __$$NearbyDriverModelImplCopyWithImpl<$Res>
    extends _$NearbyDriverModelCopyWithImpl<$Res, _$NearbyDriverModelImpl>
    implements _$$NearbyDriverModelImplCopyWith<$Res> {
  __$$NearbyDriverModelImplCopyWithImpl(_$NearbyDriverModelImpl _value,
      $Res Function(_$NearbyDriverModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationId = null,
    Object? driver = null,
  }) {
    return _then(_$NearbyDriverModelImpl(
      registrationId: null == registrationId
          ? _value.registrationId
          : registrationId // ignore: cast_nullable_to_non_nullable
              as int,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NearbyDriverModelImpl implements _NearbyDriverModel {
  const _$NearbyDriverModelImpl(
      {required this.registrationId, required this.driver});

  factory _$NearbyDriverModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearbyDriverModelImplFromJson(json);

  @override
  final int registrationId;
  @override
  final DriverModel driver;

  @override
  String toString() {
    return 'NearbyDriverModel(registrationId: $registrationId, driver: $driver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyDriverModelImpl &&
            (identical(other.registrationId, registrationId) ||
                other.registrationId == registrationId) &&
            (identical(other.driver, driver) || other.driver == driver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, registrationId, driver);

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyDriverModelImplCopyWith<_$NearbyDriverModelImpl> get copyWith =>
      __$$NearbyDriverModelImplCopyWithImpl<_$NearbyDriverModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NearbyDriverModelImplToJson(
      this,
    );
  }
}

abstract class _NearbyDriverModel implements NearbyDriverModel {
  const factory _NearbyDriverModel(
      {required final int registrationId,
      required final DriverModel driver}) = _$NearbyDriverModelImpl;

  factory _NearbyDriverModel.fromJson(Map<String, dynamic> json) =
      _$NearbyDriverModelImpl.fromJson;

  @override
  int get registrationId;
  @override
  DriverModel get driver;

  /// Create a copy of NearbyDriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NearbyDriverModelImplCopyWith<_$NearbyDriverModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
