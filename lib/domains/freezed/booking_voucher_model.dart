

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'package:flutter_application_1/domains/freezed/user_model.dart';

part 'booking_voucher_model.freezed.dart';
part 'booking_voucher_model.g.dart';

@freezed
class BookingVoucherElementModel with _$BookingVoucherElementModel {
  const factory BookingVoucherElementModel({
    required int id,
    String? booking,
    required String voucher,
    required bool used,
    UserModel? user,
  }) = _BookingVoucherElementModel;

  factory BookingVoucherElementModel.fromJson(Map<String, dynamic> json) => _$BookingVoucherElementModelFromJson(json);
}

@freezed
class VoucherModel with _$VoucherModel {
  const factory VoucherModel({
    required int voucherId,
    required String code,
    required String description,
    required int discount,
    required String expiryDate,
    required bool status,
    required List<String> bookings,
    required List<BookingVoucherElementModel> userVouchers,
    required List<BookingVoucherElementModel> bookingVouchers,
  }) = _VoucherModel;

  factory VoucherModel.fromJson(Map<String, dynamic> json) => _$VoucherModelFromJson(json);
}