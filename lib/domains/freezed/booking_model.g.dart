// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      bookingDriverId: (json['bookingDriverId'] as num).toInt(),
      bookingDetail: BookingDetailModel.fromJson(
          json['bookingDetail'] as Map<String, dynamic>),
      driverId: (json['driverId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'bookingDriverId': instance.bookingDriverId,
      'bookingDetail': instance.bookingDetail,
      'driverId': instance.driverId,
      'amount': instance.amount,
    };
