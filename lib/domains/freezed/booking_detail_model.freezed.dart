// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingDetailModel _$BookingDetailModelFromJson(Map<String, dynamic> json) {
  return _BookingDetailModel.fromJson(json);
}

/// @nodoc
mixin _$BookingDetailModel {
  int get bookingId => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  RegistrationFormModel get registration => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get pickupLocation => throw _privateConstructorUsedError;
  String get dropoffLocation => throw _privateConstructorUsedError;
  String get pickupTime => throw _privateConstructorUsedError;
  String get dropoffTime => throw _privateConstructorUsedError;
  int get distance => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<VoucherModel> get vouchers => throw _privateConstructorUsedError;

  /// Serializes this BookingDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailModelCopyWith<BookingDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailModelCopyWith<$Res> {
  factory $BookingDetailModelCopyWith(
          BookingDetailModel value, $Res Function(BookingDetailModel) then) =
      _$BookingDetailModelCopyWithImpl<$Res, BookingDetailModel>;
  @useResult
  $Res call(
      {int bookingId,
      UserModel user,
      RegistrationFormModel registration,
      int amount,
      String pickupLocation,
      String dropoffLocation,
      String pickupTime,
      String dropoffTime,
      int distance,
      String status,
      List<VoucherModel> vouchers});

  $UserModelCopyWith<$Res> get user;
  $RegistrationFormModelCopyWith<$Res> get registration;
}

/// @nodoc
class _$BookingDetailModelCopyWithImpl<$Res, $Val extends BookingDetailModel>
    implements $BookingDetailModelCopyWith<$Res> {
  _$BookingDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? user = null,
    Object? registration = null,
    Object? amount = null,
    Object? pickupLocation = null,
    Object? dropoffLocation = null,
    Object? pickupTime = null,
    Object? dropoffTime = null,
    Object? distance = null,
    Object? status = null,
    Object? vouchers = null,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as RegistrationFormModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffLocation: null == dropoffLocation
          ? _value.dropoffLocation
          : dropoffLocation // ignore: cast_nullable_to_non_nullable
              as String,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffTime: null == dropoffTime
          ? _value.dropoffTime
          : dropoffTime // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<VoucherModel>,
    ) as $Val);
  }

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegistrationFormModelCopyWith<$Res> get registration {
    return $RegistrationFormModelCopyWith<$Res>(_value.registration, (value) {
      return _then(_value.copyWith(registration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingDetailModelImplCopyWith<$Res>
    implements $BookingDetailModelCopyWith<$Res> {
  factory _$$BookingDetailModelImplCopyWith(_$BookingDetailModelImpl value,
          $Res Function(_$BookingDetailModelImpl) then) =
      __$$BookingDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int bookingId,
      UserModel user,
      RegistrationFormModel registration,
      int amount,
      String pickupLocation,
      String dropoffLocation,
      String pickupTime,
      String dropoffTime,
      int distance,
      String status,
      List<VoucherModel> vouchers});

  @override
  $UserModelCopyWith<$Res> get user;
  @override
  $RegistrationFormModelCopyWith<$Res> get registration;
}

/// @nodoc
class __$$BookingDetailModelImplCopyWithImpl<$Res>
    extends _$BookingDetailModelCopyWithImpl<$Res, _$BookingDetailModelImpl>
    implements _$$BookingDetailModelImplCopyWith<$Res> {
  __$$BookingDetailModelImplCopyWithImpl(_$BookingDetailModelImpl _value,
      $Res Function(_$BookingDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? user = null,
    Object? registration = null,
    Object? amount = null,
    Object? pickupLocation = null,
    Object? dropoffLocation = null,
    Object? pickupTime = null,
    Object? dropoffTime = null,
    Object? distance = null,
    Object? status = null,
    Object? vouchers = null,
  }) {
    return _then(_$BookingDetailModelImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as RegistrationFormModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      pickupLocation: null == pickupLocation
          ? _value.pickupLocation
          : pickupLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffLocation: null == dropoffLocation
          ? _value.dropoffLocation
          : dropoffLocation // ignore: cast_nullable_to_non_nullable
              as String,
      pickupTime: null == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as String,
      dropoffTime: null == dropoffTime
          ? _value.dropoffTime
          : dropoffTime // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<VoucherModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingDetailModelImpl implements _BookingDetailModel {
  const _$BookingDetailModelImpl(
      {required this.bookingId,
      required this.user,
      required this.registration,
      required this.amount,
      required this.pickupLocation,
      required this.dropoffLocation,
      required this.pickupTime,
      required this.dropoffTime,
      required this.distance,
      required this.status,
      required final List<VoucherModel> vouchers})
      : _vouchers = vouchers;

  factory _$BookingDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingDetailModelImplFromJson(json);

  @override
  final int bookingId;
  @override
  final UserModel user;
  @override
  final RegistrationFormModel registration;
  @override
  final int amount;
  @override
  final String pickupLocation;
  @override
  final String dropoffLocation;
  @override
  final String pickupTime;
  @override
  final String dropoffTime;
  @override
  final int distance;
  @override
  final String status;
  final List<VoucherModel> _vouchers;
  @override
  List<VoucherModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  String toString() {
    return 'BookingDetailModel(bookingId: $bookingId, user: $user, registration: $registration, amount: $amount, pickupLocation: $pickupLocation, dropoffLocation: $dropoffLocation, pickupTime: $pickupTime, dropoffTime: $dropoffTime, distance: $distance, status: $status, vouchers: $vouchers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailModelImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.pickupLocation, pickupLocation) ||
                other.pickupLocation == pickupLocation) &&
            (identical(other.dropoffLocation, dropoffLocation) ||
                other.dropoffLocation == dropoffLocation) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.dropoffTime, dropoffTime) ||
                other.dropoffTime == dropoffTime) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bookingId,
      user,
      registration,
      amount,
      pickupLocation,
      dropoffLocation,
      pickupTime,
      dropoffTime,
      distance,
      status,
      const DeepCollectionEquality().hash(_vouchers));

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailModelImplCopyWith<_$BookingDetailModelImpl> get copyWith =>
      __$$BookingDetailModelImplCopyWithImpl<_$BookingDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDetailModelImplToJson(
      this,
    );
  }
}

abstract class _BookingDetailModel implements BookingDetailModel {
  const factory _BookingDetailModel(
      {required final int bookingId,
      required final UserModel user,
      required final RegistrationFormModel registration,
      required final int amount,
      required final String pickupLocation,
      required final String dropoffLocation,
      required final String pickupTime,
      required final String dropoffTime,
      required final int distance,
      required final String status,
      required final List<VoucherModel> vouchers}) = _$BookingDetailModelImpl;

  factory _BookingDetailModel.fromJson(Map<String, dynamic> json) =
      _$BookingDetailModelImpl.fromJson;

  @override
  int get bookingId;
  @override
  UserModel get user;
  @override
  RegistrationFormModel get registration;
  @override
  int get amount;
  @override
  String get pickupLocation;
  @override
  String get dropoffLocation;
  @override
  String get pickupTime;
  @override
  String get dropoffTime;
  @override
  int get distance;
  @override
  String get status;
  @override
  List<VoucherModel> get vouchers;

  /// Create a copy of BookingDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailModelImplCopyWith<_$BookingDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
