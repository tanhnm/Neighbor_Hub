
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
part 'nearby_driver_model.freezed.dart';
part 'nearby_driver_model.g.dart';

List<NearbyDriverModel> bookingModelFromJson(String str) => List<NearbyDriverModel>.from(json.decode(str).map((x) => NearbyDriverModel.fromJson(x)));

String bookingModelToJson(List<NearbyDriverModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class NearbyDriverModel with _$NearbyDriverModel {
  const factory NearbyDriverModel({
    required int registrationId,
    required DriverModel driver,
  }) = _NearbyDriverModel;

  factory NearbyDriverModel.fromJson(Map<String, dynamic> json) => _$NearbyDriverModelFromJson(json);
}