// To parse this JSON data, do
//
//     final RegistrationFormEntity = RegistrationFormEntityFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part '../booking.freezed.dart';
part '../booking.g.dart';

RegistrationFormEntity RegistrationFormEntityFromJson(String str) =>
    RegistrationFormEntity.fromJson(json.decode(str));

String RegistrationFormEntityToJson(RegistrationFormEntity data) =>
    json.encode(data.toJson());

@freezed
class RegistrationFormEntity with _$RegistrationFormEntity {
  const factory RegistrationFormEntity({
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
  }) = _RegistrationFormEntity;

  factory RegistrationFormEntity.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFormEntityFromJson(json);
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
