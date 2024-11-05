import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'registration_form_model.g.dart';
part 'registration_form_model.freezed.dart';



@freezed
class RegistrationFormModel with _$RegistrationFormModel {
  const factory RegistrationFormModel({
    required int registrationId,
    required String licensePlate,
    required String vehicleType,
     String? driversLicenseNumber,
     String? driversLicenseImgFront,
     String? driversLicenseImgBack,
     String? lltpImg,
     String? vehicleRegistrationImg,
     String? healthCheckDay,
     String? vehicleInsuranceImgFront,
     String? vehicleInsuranceImgBack,
     String? tin,
     int? lat,
     int? lon,
     DriverModel? driver,
     int? totalStar,
    required int status,
  }) = _RegistrationFormModel;

  factory RegistrationFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFormModelFromJson(json);
}