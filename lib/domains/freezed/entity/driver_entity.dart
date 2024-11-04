// To parse this JSON data, do
//
//     final DriverEntity = DriverEntityFromMap(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part '../driver_entity.freezed.dart';
part '../driver_entity.g.dart';

DriverEntity DriverEntityFromMap(String str) =>
    DriverEntity.fromMap(json.decode(str));

String DriverEntityToMap(DriverEntity data) => json.encode(data.toMap());

@freezed
class DriverEntity with _$DriverEntity {
  const factory DriverEntity({
    int driverId,
    String username,
    String phone,
    String email,
    int averageRating,
    int revenue,
  }) = _DriverEntity;

  factory DriverEntity.fromJson(Map<String, dynamic> json) =>
      _$DriverEntityFromJson(json);
}
