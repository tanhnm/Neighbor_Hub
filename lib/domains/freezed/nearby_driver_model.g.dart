// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NearbyDriverModelImpl _$$NearbyDriverModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NearbyDriverModelImpl(
      registrationId: (json['registrationId'] as num).toInt(),
      driver: DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NearbyDriverModelImplToJson(
        _$NearbyDriverModelImpl instance) =>
    <String, dynamic>{
      'registrationId': instance.registrationId,
      'driver': instance.driver,
    };
