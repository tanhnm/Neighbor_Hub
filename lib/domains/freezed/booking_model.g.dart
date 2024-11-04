// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      bookingDriverId: (json['bookingDriverId'] as num).toInt(),
      booking: BookingDetail.fromJson(json['booking'] as Map<String, dynamic>),
      driverId: (json['driverId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'bookingDriverId': instance.bookingDriverId,
      'booking': instance.booking,
      'driverId': instance.driverId,
      'amount': instance.amount,
    };

_$BookingDetailImpl _$$BookingDetailImplFromJson(Map<String, dynamic> json) =>
    _$BookingDetailImpl(
      bookingId: (json['bookingId'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      registration:
          Registration.fromJson(json['registration'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toInt(),
      pickupLocation: json['pickupLocation'] as String,
      dropoffLocation: json['dropoffLocation'] as String,
      pickupTime: json['pickupTime'] as String,
      dropoffTime: json['dropoffTime'] as String,
      distance: (json['distance'] as num).toInt(),
      status: json['status'] as String,
      vouchers: (json['vouchers'] as List<dynamic>)
          .map((e) => Voucher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BookingDetailImplToJson(_$BookingDetailImpl instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'user': instance.user,
      'registration': instance.registration,
      'amount': instance.amount,
      'pickupLocation': instance.pickupLocation,
      'dropoffLocation': instance.dropoffLocation,
      'pickupTime': instance.pickupTime,
      'dropoffTime': instance.dropoffTime,
      'distance': instance.distance,
      'status': instance.status,
      'vouchers': instance.vouchers,
    };

_$RegistrationImpl _$$RegistrationImplFromJson(Map<String, dynamic> json) =>
    _$RegistrationImpl(
      registrationId: (json['registrationId'] as num).toInt(),
      licensePlate: json['licensePlate'] as String,
      vehicleType: json['vehicleType'] as String,
      driversLicenseNumber: json['driversLicenseNumber'] as String,
      driversLicenseImgFront: json['driversLicenseImgFront'] as String,
      driversLicenseImgBack: json['driversLicenseImgBack'] as String,
      lltpImg: json['lltpImg'] as String,
      vehicleRegistrationImg: json['vehicleRegistrationImg'] as String,
      healthCheckDay: json['healthCheckDay'] as String,
      vehicleInsuranceImgFront: json['vehicleInsuranceImgFront'] as String,
      vehicleInsuranceImgBack: json['vehicleInsuranceImgBack'] as String,
      tin: json['tin'] as String,
      lat: (json['lat'] as num).toInt(),
      lon: (json['lon'] as num).toInt(),
      driver: DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      totalStar: (json['totalStar'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$$RegistrationImplToJson(_$RegistrationImpl instance) =>
    <String, dynamic>{
      'registrationId': instance.registrationId,
      'licensePlate': instance.licensePlate,
      'vehicleType': instance.vehicleType,
      'driversLicenseNumber': instance.driversLicenseNumber,
      'driversLicenseImgFront': instance.driversLicenseImgFront,
      'driversLicenseImgBack': instance.driversLicenseImgBack,
      'lltpImg': instance.lltpImg,
      'vehicleRegistrationImg': instance.vehicleRegistrationImg,
      'healthCheckDay': instance.healthCheckDay,
      'vehicleInsuranceImgFront': instance.vehicleInsuranceImgFront,
      'vehicleInsuranceImgBack': instance.vehicleInsuranceImgBack,
      'tin': instance.tin,
      'lat': instance.lat,
      'lon': instance.lon,
      'driver': instance.driver,
      'totalStar': instance.totalStar,
      'status': instance.status,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'status': instance.status,
    };

_$VoucherImpl _$$VoucherImplFromJson(Map<String, dynamic> json) =>
    _$VoucherImpl(
      voucherId: (json['voucherId'] as num).toInt(),
      code: json['code'] as String,
      description: json['description'] as String,
      discount: (json['discount'] as num).toInt(),
      expiryDate: json['expiryDate'] as String,
      status: json['status'] as bool,
      bookings:
          (json['bookings'] as List<dynamic>).map((e) => e as String).toList(),
      userVouchers: (json['userVouchers'] as List<dynamic>)
          .map((e) => BookingVoucherElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingVouchers: (json['bookingVouchers'] as List<dynamic>)
          .map((e) => BookingVoucherElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VoucherImplToJson(_$VoucherImpl instance) =>
    <String, dynamic>{
      'voucherId': instance.voucherId,
      'code': instance.code,
      'description': instance.description,
      'discount': instance.discount,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'bookings': instance.bookings,
      'userVouchers': instance.userVouchers,
      'bookingVouchers': instance.bookingVouchers,
    };

_$BookingVoucherElementImpl _$$BookingVoucherElementImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingVoucherElementImpl(
      id: (json['id'] as num).toInt(),
      booking: json['booking'] as String?,
      voucher: json['voucher'] as String,
      used: json['used'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookingVoucherElementImplToJson(
        _$BookingVoucherElementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking': instance.booking,
      'voucher': instance.voucher,
      'used': instance.used,
      'user': instance.user,
    };
