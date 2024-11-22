import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'response_data.freezed.dart';
part 'response_data.g.dart';

ResponseData responseDataFromJson(String str) => ResponseData.fromJson(json.decode(str));

String responseDataToJson(ResponseData data) => json.encode(data.toJson());

@freezed
class ResponseData with _$ResponseData {
  const factory ResponseData({
    required int code,
    required String message,
    required int timestamp,
    required BookingDetailModel data,
  }) = _ResponseData;

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
}