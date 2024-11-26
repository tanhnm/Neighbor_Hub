

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'dealing_model.g.dart';
part 'dealing_model.freezed.dart';

DealingModel dealingModelFromJson(String str) => DealingModel.fromJson(json.decode(str));

String dealingModelToJson(DealingModel data) => json.encode(data.toJson());

@freezed
class DealingModel with _$DealingModel {
  const factory DealingModel({
    required int driverId,
    required int amount,
    required int bookingId,
    required bool status,
  }) = _DealingModel;

  factory DealingModel.fromJson(Map<String, dynamic> json) => _$DealingModelFromJson(json);
}