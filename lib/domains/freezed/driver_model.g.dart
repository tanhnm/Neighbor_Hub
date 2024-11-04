// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      driverId: (json['driverId'] as num).toInt(),
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      averageRating: (json['averageRating'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'averageRating': instance.averageRating,
      'revenue': instance.revenue,
    };
