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
    required String driversLicenseNumber,
    required String driversLicenseImgFront,
    required String driversLicenseImgBack,
    required String lltpImg,
    required String vehicleRegistrationImg,
    required String healthCheckDay,
    required String vehicleInsuranceImgFront,
    required String vehicleInsuranceImgBack,
    required String tin,
    required int lat,
    required int lon,
    required DriverModel driver,
    required int totalStar,
    required int status,
  }) = _RegistrationFormModel;

  factory RegistrationFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFormModelFromJson(json);
}