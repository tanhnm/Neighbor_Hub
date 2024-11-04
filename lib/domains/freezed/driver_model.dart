import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    required int driverId,
    required String username,
    required String phone,
    required String email,
    required int averageRating,
    required int revenue,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) => _$DriverModelFromJson(json);
}