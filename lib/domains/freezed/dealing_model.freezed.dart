// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dealing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DealingModel _$DealingModelFromJson(Map<String, dynamic> json) {
  return _DealingModel.fromJson(json);
}

/// @nodoc
mixin _$DealingModel {
  int get driverId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get bookingId => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this DealingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DealingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DealingModelCopyWith<DealingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealingModelCopyWith<$Res> {
  factory $DealingModelCopyWith(
          DealingModel value, $Res Function(DealingModel) then) =
      _$DealingModelCopyWithImpl<$Res, DealingModel>;
  @useResult
  $Res call({int driverId, int amount, int bookingId, bool status});
}

/// @nodoc
class _$DealingModelCopyWithImpl<$Res, $Val extends DealingModel>
    implements $DealingModelCopyWith<$Res> {
  _$DealingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DealingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = null,
    Object? amount = null,
    Object? bookingId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealingModelImplCopyWith<$Res>
    implements $DealingModelCopyWith<$Res> {
  factory _$$DealingModelImplCopyWith(
          _$DealingModelImpl value, $Res Function(_$DealingModelImpl) then) =
      __$$DealingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int driverId, int amount, int bookingId, bool status});
}

/// @nodoc
class __$$DealingModelImplCopyWithImpl<$Res>
    extends _$DealingModelCopyWithImpl<$Res, _$DealingModelImpl>
    implements _$$DealingModelImplCopyWith<$Res> {
  __$$DealingModelImplCopyWithImpl(
      _$DealingModelImpl _value, $Res Function(_$DealingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DealingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = null,
    Object? amount = null,
    Object? bookingId = null,
    Object? status = null,
  }) {
    return _then(_$DealingModelImpl(
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealingModelImpl implements _DealingModel {
  const _$DealingModelImpl(
      {required this.driverId,
      required this.amount,
      required this.bookingId,
      required this.status});

  factory _$DealingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealingModelImplFromJson(json);

  @override
  final int driverId;
  @override
  final int amount;
  @override
  final int bookingId;
  @override
  final bool status;

  @override
  String toString() {
    return 'DealingModel(driverId: $driverId, amount: $amount, bookingId: $bookingId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealingModelImpl &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, driverId, amount, bookingId, status);

  /// Create a copy of DealingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DealingModelImplCopyWith<_$DealingModelImpl> get copyWith =>
      __$$DealingModelImplCopyWithImpl<_$DealingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealingModelImplToJson(
      this,
    );
  }
}

abstract class _DealingModel implements DealingModel {
  const factory _DealingModel(
      {required final int driverId,
      required final int amount,
      required final int bookingId,
      required final bool status}) = _$DealingModelImpl;

  factory _DealingModel.fromJson(Map<String, dynamic> json) =
      _$DealingModelImpl.fromJson;

  @override
  int get driverId;
  @override
  int get amount;
  @override
  int get bookingId;
  @override
  bool get status;

  /// Create a copy of DealingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DealingModelImplCopyWith<_$DealingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
