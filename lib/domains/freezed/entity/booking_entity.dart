import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part '../booking_entity.freezed.dart';
part '../booking_entity.g.dart';

BookingEntity BookingEntityFromJson(String str) =>
    BookingEntity.fromJson(json.decode(str));

String BookingEntityToJson(BookingEntity data) => json.encode(data.toJson());

@freezed
class BookingEntity with _$BookingEntity {
  const factory BookingEntity({
    int bookingId,
    Registration registration,
    String pickupLocation,
    String dropoffLocation,
    DateTime pickupTime,
    DateTime dropoffTime,
    int distance,
    int amount,
    String status,
    User user,
    String qrPayment,
  }) = _BookingEntity;

  factory BookingEntity.fromJson(Map<String, dynamic> json) =>
      _$BookingEntityFromJson(json);
}

@freezed
class Registration with _$Registration {
  const factory Registration({
    int registrationId,
    String licensePlate,
    String vehicleType,
    String driversLicenseNumber,
    String driversLicenseImgFront,
    String driversLicenseImgBack,
    String lltpImg,
    String vehicleRegistrationImg,
    DateTime healthCheckDay,
    String vehicleInsuranceImgFront,
    String vehicleInsuranceImgBack,
    String tin,
    int lat,
    int lon,
    Driver driver,
    int totalStar,
    int status,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}

@freezed
class Driver with _$Driver {
  const factory Driver({
    int driverId,
    String username,
    String phone,
    String email,
    int averageRating,
    int revenue,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    int userId,
    String username,
    String phone,
    String email,
    String password,
    String role,
    bool status,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
