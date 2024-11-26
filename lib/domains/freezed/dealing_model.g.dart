// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealingModelImpl _$$DealingModelImplFromJson(Map<String, dynamic> json) =>
    _$DealingModelImpl(
      driverId: (json['driverId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      bookingId: (json['bookingId'] as num).toInt(),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$$DealingModelImplToJson(_$DealingModelImpl instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'amount': instance.amount,
      'bookingId': instance.bookingId,
      'status': instance.status,
    };
