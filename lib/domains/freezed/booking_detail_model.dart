

import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'booking_voucher_model.dart';

part 'booking_detail_model.freezed.dart';
part 'booking_detail_model.g.dart';

@freezed
class BookingDetailModel with _$BookingDetailModel {
  const factory BookingDetailModel({
    required int bookingId,
    required UserModel user,
    required RegistrationFormModel registration,
    required int amount,
    required String pickupLocation,
    required String dropoffLocation,
    required String pickupTime,
    required String dropoffTime,
    required int distance,
    required String status,
    required List<VoucherModel> vouchers,
  }) = _BookingDetailModel;

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) => _$BookingDetailModelFromJson(json);
}
