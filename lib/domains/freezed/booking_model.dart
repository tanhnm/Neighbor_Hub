// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../user_model.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class BookingModel with _$BookingModel {
  const factory BookingModel({
    required int bookingDriverId,
    required BookingDetail booking,
    required int driverId,
    required int amount,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
}

@freezed
class BookingDetail with _$BookingDetail {
  const factory BookingDetail({
    required int bookingId,
    required User user,
    required Registration registration,
    required int amount,
    required String pickupLocation,
    required String dropoffLocation,
    required String pickupTime,
    required String dropoffTime,
    required int distance,
    required String status,
    required List<Voucher> vouchers,
  }) = _BookingDetail;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => _$BookingDetailFromJson(json);
}

@freezed
class Registration with _$Registration {
  const factory Registration({
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
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) => _$RegistrationFromJson(json);
}




@freezed
class Voucher with _$Voucher {
  const factory Voucher({
    required int voucherId,
    required String code,
    required String description,
    required int discount,
    required String expiryDate,
    required bool status,
    required List<String> bookings,
    required List<BookingVoucherElement> userVouchers,
    required List<BookingVoucherElement> bookingVouchers,
  }) = _Voucher;

  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);
}

@freezed
class BookingVoucherElement with _$BookingVoucherElement {
  const factory BookingVoucherElement({
    required int id,
    String? booking,
    required String voucher,
    required bool used,
    User? user,
  }) = _BookingVoucherElement;

  factory BookingVoucherElement.fromJson(Map<String, dynamic> json) => _$BookingVoucherElementFromJson(json);
}
