import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part '../booking_driver_model.freezed.dart';
part '../booking_driver_model.g.dart';

BookingDriverModel BookingDriverModelFromJson(String str) =>
    BookingDriverModel.fromJson(json.decode(str));

String BookingDriverModelToJson(Welcome data) => json.encode(data.toJson());

@freezed
class BookingDriverModel with _$BookingDriverModel {
  const factory BookingDriverModel({
    int bookingDriverId,
    Booking booking,
    int driverId,
    int amount,
  }) = _BookingDriverModel;

  factory BookingDriverModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDriverModelFromJson(json);
}

@freezed
class Booking with _$Booking {
  const factory Booking({
    int bookingId,
    User user,
    Registration registration,
    int amount,
    String pickupLocation,
    String dropoffLocation,
    DateTime pickupTime,
    dynamic dropoffTime,
    int distance,
    String status,
    List<dynamic> vouchers,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
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
    double lat,
    double lon,
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
