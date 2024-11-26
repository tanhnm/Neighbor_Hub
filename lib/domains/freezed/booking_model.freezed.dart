// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  int get bookingDriverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking')
  BookingDetailModel get bookingDetail => throw _privateConstructorUsedError;
  int get driverId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call(
      {int bookingDriverId,
      @JsonKey(name: 'booking') BookingDetailModel bookingDetail,
      int driverId,
      int amount});

  $BookingDetailModelCopyWith<$Res> get bookingDetail;
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDriverId = null,
    Object? bookingDetail = null,
    Object? driverId = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      bookingDriverId: null == bookingDriverId
          ? _value.bookingDriverId
          : bookingDriverId // ignore: cast_nullable_to_non_nullable
              as int,
      bookingDetail: null == bookingDetail
          ? _value.bookingDetail
          : bookingDetail // ignore: cast_nullable_to_non_nullable
              as BookingDetailModel,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingDetailModelCopyWith<$Res> get bookingDetail {
    return $BookingDetailModelCopyWith<$Res>(_value.bookingDetail, (value) {
      return _then(_value.copyWith(bookingDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingModelImplCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$BookingModelImplCopyWith(
          _$BookingModelImpl value, $Res Function(_$BookingModelImpl) then) =
      __$$BookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int bookingDriverId,
      @JsonKey(name: 'booking') BookingDetailModel bookingDetail,
      int driverId,
      int amount});

  @override
  $BookingDetailModelCopyWith<$Res> get bookingDetail;
}

/// @nodoc
class __$$BookingModelImplCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$BookingModelImpl>
    implements _$$BookingModelImplCopyWith<$Res> {
  __$$BookingModelImplCopyWithImpl(
      _$BookingModelImpl _value, $Res Function(_$BookingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDriverId = null,
    Object? bookingDetail = null,
    Object? driverId = null,
    Object? amount = null,
  }) {
    return _then(_$BookingModelImpl(
      bookingDriverId: null == bookingDriverId
          ? _value.bookingDriverId
          : bookingDriverId // ignore: cast_nullable_to_non_nullable
              as int,
      bookingDetail: null == bookingDetail
          ? _value.bookingDetail
          : bookingDetail // ignore: cast_nullable_to_non_nullable
              as BookingDetailModel,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingModelImpl implements _BookingModel {
  const _$BookingModelImpl(
      {required this.bookingDriverId,
      @JsonKey(name: 'booking') required this.bookingDetail,
      required this.driverId,
      required this.amount});

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final int bookingDriverId;
  @override
  @JsonKey(name: 'booking')
  final BookingDetailModel bookingDetail;
  @override
  final int driverId;
  @override
  final int amount;

  @override
  String toString() {
    return 'BookingModel(bookingDriverId: $bookingDriverId, bookingDetail: $bookingDetail, driverId: $driverId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.bookingDriverId, bookingDriverId) ||
                other.bookingDriverId == bookingDriverId) &&
            (identical(other.bookingDetail, bookingDetail) ||
                other.bookingDetail == bookingDetail) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, bookingDriverId, bookingDetail, driverId, amount);

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      __$$BookingModelImplCopyWithImpl<_$BookingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingModelImplToJson(
      this,
    );
  }
}

abstract class _BookingModel implements BookingModel {
  const factory _BookingModel(
      {required final int bookingDriverId,
      @JsonKey(name: 'booking') required final BookingDetailModel bookingDetail,
      required final int driverId,
      required final int amount}) = _$BookingModelImpl;

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  int get bookingDriverId;
  @override
  @JsonKey(name: 'booking')
  BookingDetailModel get bookingDetail;
  @override
  int get driverId;
  @override
  int get amount;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingModelImplCopyWith<_$BookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
