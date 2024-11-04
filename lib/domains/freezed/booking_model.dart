// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'package:flutter_application_1/domains/freezed/booking_voucher_model.dart';
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'user_model.dart';
import 'booking_detail_model.dart';
part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class BookingModel with _$BookingModel {
  const factory BookingModel({
    required int bookingDriverId,
    required BookingDetailModel bookingDetail,
    required int driverId,
    required int amount,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
}






