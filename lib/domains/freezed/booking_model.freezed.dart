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
  BookingDetail get booking => throw _privateConstructorUsedError;
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
      {int bookingDriverId, BookingDetail booking, int driverId, int amount});

  $BookingDetailCopyWith<$Res> get booking;
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
    Object? booking = null,
    Object? driverId = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      bookingDriverId: null == bookingDriverId
          ? _value.bookingDriverId
          : bookingDriverId // ignore: cast_nullable_to_non_nullable
              as int,
      booking: null == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingDetail,
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
  $BookingDetailCopyWith<$Res> get booking {
    return $BookingDetailCopyWith<$Res>(_value.booking, (value) {
      return _then(_value.copyWith(booking: value) as $Val);
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
      {int bookingDriverId, BookingDetail booking, int driverId, int amount});

  @override
  $BookingDetailCopyWith<$Res> get booking;
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
    Object? booking = null,
    Object? driverId = null,
    Object? amount = null,
  }) {
    return _then(_$BookingModelImpl(
      bookingDriverId: null == bookingDriverId
          ? _value.bookingDriverId
          : bookingDriverId // ignore: cast_nullable_to_non_nullable
              as int,
      booking: null == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingDetail,
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
      required this.booking,
      required this.driverId,
      required this.amount});

  factory _$BookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingModelImplFromJson(json);

  @override
  final int bookingDriverId;
  @override
  final BookingDetail booking;
  @override
  final int driverId;
  @override
  final int amount;

  @override
  String toString() {
    return 'BookingModel(bookingDriverId: $bookingDriverId, booking: $booking, driverId: $driverId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingModelImpl &&
            (identical(other.bookingDriverId, bookingDriverId) ||
                other.bookingDriverId == bookingDriverId) &&
            (identical(other.booking, booking) || other.booking == booking) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bookingDriverId, booking, driverId, amount);

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
      required final BookingDetail booking,
      required final int driverId,
      required final int amount}) = _$BookingModelImpl;

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$BookingModelImpl.fromJson;

  @override
  int get bookingDriverId;
  @override
  BookingDetail get booking;
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

BookingDetail _$BookingDetailFromJson(Map<String, dynamic> json) {
  return _BookingDetail.fromJson(json);
}

/// @nodoc
mixin _$BookingDetail {
  int get bookingId => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  Registration get registration => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get pickupLocation => throw _privateConstructorUsedError;
  String get dropoffLocation => throw _privateConstructorUsedError;
  String get pickupTime => throw _privateConstructorUsedError;
  String get dropoffTime => throw _privateConstructorUsedError;
  int get distance => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<Voucher> get vouchers => throw _privateConstructorUsedError;

  /// Serializes this BookingDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailCopyWith<BookingDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailCopyWith<$Res> {
  factory $BookingDetailCopyWith(
          BookingDetail value, $Res Function(BookingDetail) then) =
      _$BookingDetailCopyWithImpl<$Res, BookingDetail>;
  @useResult
  $Res call(
      {int bookingId,
      User user,
      Registration registration,
      int amount,
      String pickupLocation,
      String dropoffLocation,
      String pickupTime,
      String dropoffTime,
      int distance,
      String status,
      List<Voucher> vouchers});

  $UserCopyWith<$Res> get user;
  $RegistrationCopyWith<$Res> get registration;
}

/// @nodoc
class _$BookingDetailCopyWithImpl<$Res, $Val extends BookingDetail>
    implements $BookingDetailCopyWith<$Res> {
  _$BookingDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetail
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
              as User,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
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
              as List<Voucher>,
    ) as $Val);
  }

  /// Create a copy of BookingDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of BookingDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegistrationCopyWith<$Res> get registration {
    return $RegistrationCopyWith<$Res>(_value.registration, (value) {
      return _then(_value.copyWith(registration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingDetailImplCopyWith<$Res>
    implements $BookingDetailCopyWith<$Res> {
  factory _$$BookingDetailImplCopyWith(
          _$BookingDetailImpl value, $Res Function(_$BookingDetailImpl) then) =
      __$$BookingDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int bookingId,
      User user,
      Registration registration,
      int amount,
      String pickupLocation,
      String dropoffLocation,
      String pickupTime,
      String dropoffTime,
      int distance,
      String status,
      List<Voucher> vouchers});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $RegistrationCopyWith<$Res> get registration;
}

/// @nodoc
class __$$BookingDetailImplCopyWithImpl<$Res>
    extends _$BookingDetailCopyWithImpl<$Res, _$BookingDetailImpl>
    implements _$$BookingDetailImplCopyWith<$Res> {
  __$$BookingDetailImplCopyWithImpl(
      _$BookingDetailImpl _value, $Res Function(_$BookingDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetail
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
    return _then(_$BookingDetailImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      registration: null == registration
          ? _value.registration
          : registration // ignore: cast_nullable_to_non_nullable
              as Registration,
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
              as List<Voucher>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingDetailImpl implements _BookingDetail {
  const _$BookingDetailImpl(
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
      required final List<Voucher> vouchers})
      : _vouchers = vouchers;

  factory _$BookingDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingDetailImplFromJson(json);

  @override
  final int bookingId;
  @override
  final User user;
  @override
  final Registration registration;
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
  final List<Voucher> _vouchers;
  @override
  List<Voucher> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  String toString() {
    return 'BookingDetail(bookingId: $bookingId, user: $user, registration: $registration, amount: $amount, pickupLocation: $pickupLocation, dropoffLocation: $dropoffLocation, pickupTime: $pickupTime, dropoffTime: $dropoffTime, distance: $distance, status: $status, vouchers: $vouchers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailImpl &&
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

  /// Create a copy of BookingDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailImplCopyWith<_$BookingDetailImpl> get copyWith =>
      __$$BookingDetailImplCopyWithImpl<_$BookingDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDetailImplToJson(
      this,
    );
  }
}

abstract class _BookingDetail implements BookingDetail {
  const factory _BookingDetail(
      {required final int bookingId,
      required final User user,
      required final Registration registration,
      required final int amount,
      required final String pickupLocation,
      required final String dropoffLocation,
      required final String pickupTime,
      required final String dropoffTime,
      required final int distance,
      required final String status,
      required final List<Voucher> vouchers}) = _$BookingDetailImpl;

  factory _BookingDetail.fromJson(Map<String, dynamic> json) =
      _$BookingDetailImpl.fromJson;

  @override
  int get bookingId;
  @override
  User get user;
  @override
  Registration get registration;
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
  List<Voucher> get vouchers;

  /// Create a copy of BookingDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailImplCopyWith<_$BookingDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Registration _$RegistrationFromJson(Map<String, dynamic> json) {
  return _Registration.fromJson(json);
}

/// @nodoc
mixin _$Registration {
  int get registrationId => throw _privateConstructorUsedError;
  String get licensePlate => throw _privateConstructorUsedError;
  String get vehicleType => throw _privateConstructorUsedError;
  String get driversLicenseNumber => throw _privateConstructorUsedError;
  String get driversLicenseImgFront => throw _privateConstructorUsedError;
  String get driversLicenseImgBack => throw _privateConstructorUsedError;
  String get lltpImg => throw _privateConstructorUsedError;
  String get vehicleRegistrationImg => throw _privateConstructorUsedError;
  String get healthCheckDay => throw _privateConstructorUsedError;
  String get vehicleInsuranceImgFront => throw _privateConstructorUsedError;
  String get vehicleInsuranceImgBack => throw _privateConstructorUsedError;
  String get tin => throw _privateConstructorUsedError;
  int get lat => throw _privateConstructorUsedError;
  int get lon => throw _privateConstructorUsedError;
  DriverModel get driver => throw _privateConstructorUsedError;
  int get totalStar => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;

  /// Serializes this Registration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationCopyWith<Registration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationCopyWith<$Res> {
  factory $RegistrationCopyWith(
          Registration value, $Res Function(Registration) then) =
      _$RegistrationCopyWithImpl<$Res, Registration>;
  @useResult
  $Res call(
      {int registrationId,
      String licensePlate,
      String vehicleType,
      String driversLicenseNumber,
      String driversLicenseImgFront,
      String driversLicenseImgBack,
      String lltpImg,
      String vehicleRegistrationImg,
      String healthCheckDay,
      String vehicleInsuranceImgFront,
      String vehicleInsuranceImgBack,
      String tin,
      int lat,
      int lon,
      DriverModel driver,
      int totalStar,
      int status});

  $DriverModelCopyWith<$Res> get driver;
}

/// @nodoc
class _$RegistrationCopyWithImpl<$Res, $Val extends Registration>
    implements $RegistrationCopyWith<$Res> {
  _$RegistrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationId = null,
    Object? licensePlate = null,
    Object? vehicleType = null,
    Object? driversLicenseNumber = null,
    Object? driversLicenseImgFront = null,
    Object? driversLicenseImgBack = null,
    Object? lltpImg = null,
    Object? vehicleRegistrationImg = null,
    Object? healthCheckDay = null,
    Object? vehicleInsuranceImgFront = null,
    Object? vehicleInsuranceImgBack = null,
    Object? tin = null,
    Object? lat = null,
    Object? lon = null,
    Object? driver = null,
    Object? totalStar = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      registrationId: null == registrationId
          ? _value.registrationId
          : registrationId // ignore: cast_nullable_to_non_nullable
              as int,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseNumber: null == driversLicenseNumber
          ? _value.driversLicenseNumber
          : driversLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseImgFront: null == driversLicenseImgFront
          ? _value.driversLicenseImgFront
          : driversLicenseImgFront // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseImgBack: null == driversLicenseImgBack
          ? _value.driversLicenseImgBack
          : driversLicenseImgBack // ignore: cast_nullable_to_non_nullable
              as String,
      lltpImg: null == lltpImg
          ? _value.lltpImg
          : lltpImg // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleRegistrationImg: null == vehicleRegistrationImg
          ? _value.vehicleRegistrationImg
          : vehicleRegistrationImg // ignore: cast_nullable_to_non_nullable
              as String,
      healthCheckDay: null == healthCheckDay
          ? _value.healthCheckDay
          : healthCheckDay // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInsuranceImgFront: null == vehicleInsuranceImgFront
          ? _value.vehicleInsuranceImgFront
          : vehicleInsuranceImgFront // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInsuranceImgBack: null == vehicleInsuranceImgBack
          ? _value.vehicleInsuranceImgBack
          : vehicleInsuranceImgBack // ignore: cast_nullable_to_non_nullable
              as String,
      tin: null == tin
          ? _value.tin
          : tin // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as int,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as int,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverModel,
      totalStar: null == totalStar
          ? _value.totalStar
          : totalStar // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Registration
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
abstract class _$$RegistrationImplCopyWith<$Res>
    implements $RegistrationCopyWith<$Res> {
  factory _$$RegistrationImplCopyWith(
          _$RegistrationImpl value, $Res Function(_$RegistrationImpl) then) =
      __$$RegistrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int registrationId,
      String licensePlate,
      String vehicleType,
      String driversLicenseNumber,
      String driversLicenseImgFront,
      String driversLicenseImgBack,
      String lltpImg,
      String vehicleRegistrationImg,
      String healthCheckDay,
      String vehicleInsuranceImgFront,
      String vehicleInsuranceImgBack,
      String tin,
      int lat,
      int lon,
      DriverModel driver,
      int totalStar,
      int status});

  @override
  $DriverModelCopyWith<$Res> get driver;
}

/// @nodoc
class __$$RegistrationImplCopyWithImpl<$Res>
    extends _$RegistrationCopyWithImpl<$Res, _$RegistrationImpl>
    implements _$$RegistrationImplCopyWith<$Res> {
  __$$RegistrationImplCopyWithImpl(
      _$RegistrationImpl _value, $Res Function(_$RegistrationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registrationId = null,
    Object? licensePlate = null,
    Object? vehicleType = null,
    Object? driversLicenseNumber = null,
    Object? driversLicenseImgFront = null,
    Object? driversLicenseImgBack = null,
    Object? lltpImg = null,
    Object? vehicleRegistrationImg = null,
    Object? healthCheckDay = null,
    Object? vehicleInsuranceImgFront = null,
    Object? vehicleInsuranceImgBack = null,
    Object? tin = null,
    Object? lat = null,
    Object? lon = null,
    Object? driver = null,
    Object? totalStar = null,
    Object? status = null,
  }) {
    return _then(_$RegistrationImpl(
      registrationId: null == registrationId
          ? _value.registrationId
          : registrationId // ignore: cast_nullable_to_non_nullable
              as int,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseNumber: null == driversLicenseNumber
          ? _value.driversLicenseNumber
          : driversLicenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseImgFront: null == driversLicenseImgFront
          ? _value.driversLicenseImgFront
          : driversLicenseImgFront // ignore: cast_nullable_to_non_nullable
              as String,
      driversLicenseImgBack: null == driversLicenseImgBack
          ? _value.driversLicenseImgBack
          : driversLicenseImgBack // ignore: cast_nullable_to_non_nullable
              as String,
      lltpImg: null == lltpImg
          ? _value.lltpImg
          : lltpImg // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleRegistrationImg: null == vehicleRegistrationImg
          ? _value.vehicleRegistrationImg
          : vehicleRegistrationImg // ignore: cast_nullable_to_non_nullable
              as String,
      healthCheckDay: null == healthCheckDay
          ? _value.healthCheckDay
          : healthCheckDay // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInsuranceImgFront: null == vehicleInsuranceImgFront
          ? _value.vehicleInsuranceImgFront
          : vehicleInsuranceImgFront // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInsuranceImgBack: null == vehicleInsuranceImgBack
          ? _value.vehicleInsuranceImgBack
          : vehicleInsuranceImgBack // ignore: cast_nullable_to_non_nullable
              as String,
      tin: null == tin
          ? _value.tin
          : tin // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as int,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as int,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverModel,
      totalStar: null == totalStar
          ? _value.totalStar
          : totalStar // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegistrationImpl implements _Registration {
  const _$RegistrationImpl(
      {required this.registrationId,
      required this.licensePlate,
      required this.vehicleType,
      required this.driversLicenseNumber,
      required this.driversLicenseImgFront,
      required this.driversLicenseImgBack,
      required this.lltpImg,
      required this.vehicleRegistrationImg,
      required this.healthCheckDay,
      required this.vehicleInsuranceImgFront,
      required this.vehicleInsuranceImgBack,
      required this.tin,
      required this.lat,
      required this.lon,
      required this.driver,
      required this.totalStar,
      required this.status});

  factory _$RegistrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistrationImplFromJson(json);

  @override
  final int registrationId;
  @override
  final String licensePlate;
  @override
  final String vehicleType;
  @override
  final String driversLicenseNumber;
  @override
  final String driversLicenseImgFront;
  @override
  final String driversLicenseImgBack;
  @override
  final String lltpImg;
  @override
  final String vehicleRegistrationImg;
  @override
  final String healthCheckDay;
  @override
  final String vehicleInsuranceImgFront;
  @override
  final String vehicleInsuranceImgBack;
  @override
  final String tin;
  @override
  final int lat;
  @override
  final int lon;
  @override
  final DriverModel driver;
  @override
  final int totalStar;
  @override
  final int status;

  @override
  String toString() {
    return 'Registration(registrationId: $registrationId, licensePlate: $licensePlate, vehicleType: $vehicleType, driversLicenseNumber: $driversLicenseNumber, driversLicenseImgFront: $driversLicenseImgFront, driversLicenseImgBack: $driversLicenseImgBack, lltpImg: $lltpImg, vehicleRegistrationImg: $vehicleRegistrationImg, healthCheckDay: $healthCheckDay, vehicleInsuranceImgFront: $vehicleInsuranceImgFront, vehicleInsuranceImgBack: $vehicleInsuranceImgBack, tin: $tin, lat: $lat, lon: $lon, driver: $driver, totalStar: $totalStar, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationImpl &&
            (identical(other.registrationId, registrationId) ||
                other.registrationId == registrationId) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.driversLicenseNumber, driversLicenseNumber) ||
                other.driversLicenseNumber == driversLicenseNumber) &&
            (identical(other.driversLicenseImgFront, driversLicenseImgFront) ||
                other.driversLicenseImgFront == driversLicenseImgFront) &&
            (identical(other.driversLicenseImgBack, driversLicenseImgBack) ||
                other.driversLicenseImgBack == driversLicenseImgBack) &&
            (identical(other.lltpImg, lltpImg) || other.lltpImg == lltpImg) &&
            (identical(other.vehicleRegistrationImg, vehicleRegistrationImg) ||
                other.vehicleRegistrationImg == vehicleRegistrationImg) &&
            (identical(other.healthCheckDay, healthCheckDay) ||
                other.healthCheckDay == healthCheckDay) &&
            (identical(
                    other.vehicleInsuranceImgFront, vehicleInsuranceImgFront) ||
                other.vehicleInsuranceImgFront == vehicleInsuranceImgFront) &&
            (identical(
                    other.vehicleInsuranceImgBack, vehicleInsuranceImgBack) ||
                other.vehicleInsuranceImgBack == vehicleInsuranceImgBack) &&
            (identical(other.tin, tin) || other.tin == tin) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.totalStar, totalStar) ||
                other.totalStar == totalStar) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      registrationId,
      licensePlate,
      vehicleType,
      driversLicenseNumber,
      driversLicenseImgFront,
      driversLicenseImgBack,
      lltpImg,
      vehicleRegistrationImg,
      healthCheckDay,
      vehicleInsuranceImgFront,
      vehicleInsuranceImgBack,
      tin,
      lat,
      lon,
      driver,
      totalStar,
      status);

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationImplCopyWith<_$RegistrationImpl> get copyWith =>
      __$$RegistrationImplCopyWithImpl<_$RegistrationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationImplToJson(
      this,
    );
  }
}

abstract class _Registration implements Registration {
  const factory _Registration(
      {required final int registrationId,
      required final String licensePlate,
      required final String vehicleType,
      required final String driversLicenseNumber,
      required final String driversLicenseImgFront,
      required final String driversLicenseImgBack,
      required final String lltpImg,
      required final String vehicleRegistrationImg,
      required final String healthCheckDay,
      required final String vehicleInsuranceImgFront,
      required final String vehicleInsuranceImgBack,
      required final String tin,
      required final int lat,
      required final int lon,
      required final DriverModel driver,
      required final int totalStar,
      required final int status}) = _$RegistrationImpl;

  factory _Registration.fromJson(Map<String, dynamic> json) =
      _$RegistrationImpl.fromJson;

  @override
  int get registrationId;
  @override
  String get licensePlate;
  @override
  String get vehicleType;
  @override
  String get driversLicenseNumber;
  @override
  String get driversLicenseImgFront;
  @override
  String get driversLicenseImgBack;
  @override
  String get lltpImg;
  @override
  String get vehicleRegistrationImg;
  @override
  String get healthCheckDay;
  @override
  String get vehicleInsuranceImgFront;
  @override
  String get vehicleInsuranceImgBack;
  @override
  String get tin;
  @override
  int get lat;
  @override
  int get lon;
  @override
  DriverModel get driver;
  @override
  int get totalStar;
  @override
  int get status;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationImplCopyWith<_$RegistrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int userId,
      String username,
      String phone,
      String email,
      String password,
      String role,
      bool status});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? phone = null,
    Object? email = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userId,
      String username,
      String phone,
      String email,
      String password,
      String role,
      bool status});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? phone = null,
    Object? email = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_$UserImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.userId,
      required this.username,
      required this.phone,
      required this.email,
      required this.password,
      required this.role,
      required this.status});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int userId;
  @override
  final String username;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String password;
  @override
  final String role;
  @override
  final bool status;

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, phone: $phone, email: $email, password: $password, role: $role, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, username, phone, email, password, role, status);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int userId,
      required final String username,
      required final String phone,
      required final String email,
      required final String password,
      required final String role,
      required final bool status}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get userId;
  @override
  String get username;
  @override
  String get phone;
  @override
  String get email;
  @override
  String get password;
  @override
  String get role;
  @override
  bool get status;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
mixin _$Voucher {
  int get voucherId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  List<String> get bookings => throw _privateConstructorUsedError;
  List<BookingVoucherElement> get userVouchers =>
      throw _privateConstructorUsedError;
  List<BookingVoucherElement> get bookingVouchers =>
      throw _privateConstructorUsedError;

  /// Serializes this Voucher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res, Voucher>;
  @useResult
  $Res call(
      {int voucherId,
      String code,
      String description,
      int discount,
      String expiryDate,
      bool status,
      List<String> bookings,
      List<BookingVoucherElement> userVouchers,
      List<BookingVoucherElement> bookingVouchers});
}

/// @nodoc
class _$VoucherCopyWithImpl<$Res, $Val extends Voucher>
    implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voucherId = null,
    Object? code = null,
    Object? description = null,
    Object? discount = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? bookings = null,
    Object? userVouchers = null,
    Object? bookingVouchers = null,
  }) {
    return _then(_value.copyWith(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userVouchers: null == userVouchers
          ? _value.userVouchers
          : userVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElement>,
      bookingVouchers: null == bookingVouchers
          ? _value.bookingVouchers
          : bookingVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherImplCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$$VoucherImplCopyWith(
          _$VoucherImpl value, $Res Function(_$VoucherImpl) then) =
      __$$VoucherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int voucherId,
      String code,
      String description,
      int discount,
      String expiryDate,
      bool status,
      List<String> bookings,
      List<BookingVoucherElement> userVouchers,
      List<BookingVoucherElement> bookingVouchers});
}

/// @nodoc
class __$$VoucherImplCopyWithImpl<$Res>
    extends _$VoucherCopyWithImpl<$Res, _$VoucherImpl>
    implements _$$VoucherImplCopyWith<$Res> {
  __$$VoucherImplCopyWithImpl(
      _$VoucherImpl _value, $Res Function(_$VoucherImpl) _then)
      : super(_value, _then);

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voucherId = null,
    Object? code = null,
    Object? description = null,
    Object? discount = null,
    Object? expiryDate = null,
    Object? status = null,
    Object? bookings = null,
    Object? userVouchers = null,
    Object? bookingVouchers = null,
  }) {
    return _then(_$VoucherImpl(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userVouchers: null == userVouchers
          ? _value._userVouchers
          : userVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElement>,
      bookingVouchers: null == bookingVouchers
          ? _value._bookingVouchers
          : bookingVouchers // ignore: cast_nullable_to_non_nullable
              as List<BookingVoucherElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherImpl implements _Voucher {
  const _$VoucherImpl(
      {required this.voucherId,
      required this.code,
      required this.description,
      required this.discount,
      required this.expiryDate,
      required this.status,
      required final List<String> bookings,
      required final List<BookingVoucherElement> userVouchers,
      required final List<BookingVoucherElement> bookingVouchers})
      : _bookings = bookings,
        _userVouchers = userVouchers,
        _bookingVouchers = bookingVouchers;

  factory _$VoucherImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherImplFromJson(json);

  @override
  final int voucherId;
  @override
  final String code;
  @override
  final String description;
  @override
  final int discount;
  @override
  final String expiryDate;
  @override
  final bool status;
  final List<String> _bookings;
  @override
  List<String> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  final List<BookingVoucherElement> _userVouchers;
  @override
  List<BookingVoucherElement> get userVouchers {
    if (_userVouchers is EqualUnmodifiableListView) return _userVouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userVouchers);
  }

  final List<BookingVoucherElement> _bookingVouchers;
  @override
  List<BookingVoucherElement> get bookingVouchers {
    if (_bookingVouchers is EqualUnmodifiableListView) return _bookingVouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookingVouchers);
  }

  @override
  String toString() {
    return 'Voucher(voucherId: $voucherId, code: $code, description: $description, discount: $discount, expiryDate: $expiryDate, status: $status, bookings: $bookings, userVouchers: $userVouchers, bookingVouchers: $bookingVouchers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherImpl &&
            (identical(other.voucherId, voucherId) ||
                other.voucherId == voucherId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            const DeepCollectionEquality()
                .equals(other._userVouchers, _userVouchers) &&
            const DeepCollectionEquality()
                .equals(other._bookingVouchers, _bookingVouchers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      voucherId,
      code,
      description,
      discount,
      expiryDate,
      status,
      const DeepCollectionEquality().hash(_bookings),
      const DeepCollectionEquality().hash(_userVouchers),
      const DeepCollectionEquality().hash(_bookingVouchers));

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      __$$VoucherImplCopyWithImpl<_$VoucherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherImplToJson(
      this,
    );
  }
}

abstract class _Voucher implements Voucher {
  const factory _Voucher(
          {required final int voucherId,
          required final String code,
          required final String description,
          required final int discount,
          required final String expiryDate,
          required final bool status,
          required final List<String> bookings,
          required final List<BookingVoucherElement> userVouchers,
          required final List<BookingVoucherElement> bookingVouchers}) =
      _$VoucherImpl;

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$VoucherImpl.fromJson;

  @override
  int get voucherId;
  @override
  String get code;
  @override
  String get description;
  @override
  int get discount;
  @override
  String get expiryDate;
  @override
  bool get status;
  @override
  List<String> get bookings;
  @override
  List<BookingVoucherElement> get userVouchers;
  @override
  List<BookingVoucherElement> get bookingVouchers;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingVoucherElement _$BookingVoucherElementFromJson(
    Map<String, dynamic> json) {
  return _BookingVoucherElement.fromJson(json);
}

/// @nodoc
mixin _$BookingVoucherElement {
  int get id => throw _privateConstructorUsedError;
  String? get booking => throw _privateConstructorUsedError;
  String get voucher => throw _privateConstructorUsedError;
  bool get used => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  /// Serializes this BookingVoucherElement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingVoucherElementCopyWith<BookingVoucherElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingVoucherElementCopyWith<$Res> {
  factory $BookingVoucherElementCopyWith(BookingVoucherElement value,
          $Res Function(BookingVoucherElement) then) =
      _$BookingVoucherElementCopyWithImpl<$Res, BookingVoucherElement>;
  @useResult
  $Res call({int id, String? booking, String voucher, bool used, User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$BookingVoucherElementCopyWithImpl<$Res,
        $Val extends BookingVoucherElement>
    implements $BookingVoucherElementCopyWith<$Res> {
  _$BookingVoucherElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? booking = freezed,
    Object? voucher = null,
    Object? used = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      booking: freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as String?,
      voucher: null == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingVoucherElementImplCopyWith<$Res>
    implements $BookingVoucherElementCopyWith<$Res> {
  factory _$$BookingVoucherElementImplCopyWith(
          _$BookingVoucherElementImpl value,
          $Res Function(_$BookingVoucherElementImpl) then) =
      __$$BookingVoucherElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? booking, String voucher, bool used, User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$BookingVoucherElementImplCopyWithImpl<$Res>
    extends _$BookingVoucherElementCopyWithImpl<$Res,
        _$BookingVoucherElementImpl>
    implements _$$BookingVoucherElementImplCopyWith<$Res> {
  __$$BookingVoucherElementImplCopyWithImpl(_$BookingVoucherElementImpl _value,
      $Res Function(_$BookingVoucherElementImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? booking = freezed,
    Object? voucher = null,
    Object? used = null,
    Object? user = freezed,
  }) {
    return _then(_$BookingVoucherElementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      booking: freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as String?,
      voucher: null == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingVoucherElementImpl implements _BookingVoucherElement {
  const _$BookingVoucherElementImpl(
      {required this.id,
      this.booking,
      required this.voucher,
      required this.used,
      this.user});

  factory _$BookingVoucherElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingVoucherElementImplFromJson(json);

  @override
  final int id;
  @override
  final String? booking;
  @override
  final String voucher;
  @override
  final bool used;
  @override
  final User? user;

  @override
  String toString() {
    return 'BookingVoucherElement(id: $id, booking: $booking, voucher: $voucher, used: $used, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingVoucherElementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.booking, booking) || other.booking == booking) &&
            (identical(other.voucher, voucher) || other.voucher == voucher) &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, booking, voucher, used, user);

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingVoucherElementImplCopyWith<_$BookingVoucherElementImpl>
      get copyWith => __$$BookingVoucherElementImplCopyWithImpl<
          _$BookingVoucherElementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingVoucherElementImplToJson(
      this,
    );
  }
}

abstract class _BookingVoucherElement implements BookingVoucherElement {
  const factory _BookingVoucherElement(
      {required final int id,
      final String? booking,
      required final String voucher,
      required final bool used,
      final User? user}) = _$BookingVoucherElementImpl;

  factory _BookingVoucherElement.fromJson(Map<String, dynamic> json) =
      _$BookingVoucherElementImpl.fromJson;

  @override
  int get id;
  @override
  String? get booking;
  @override
  String get voucher;
  @override
  bool get used;
  @override
  User? get user;

  /// Create a copy of BookingVoucherElement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingVoucherElementImplCopyWith<_$BookingVoucherElementImpl>
      get copyWith => throw _privateConstructorUsedError;
}
