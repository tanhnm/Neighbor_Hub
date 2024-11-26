// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseDataImpl _$$ResponseDataImplFromJson(Map<String, dynamic> json) =>
    _$ResponseDataImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      data: BookingDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResponseDataImplToJson(_$ResponseDataImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'data': instance.data,
    };
