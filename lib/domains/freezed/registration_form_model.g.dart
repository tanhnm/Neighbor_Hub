// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegistrationFormModelImpl _$$RegistrationFormModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegistrationFormModelImpl(
      registrationId: (json['registrationId'] as num).toInt(),
      licensePlate: json['licensePlate'] as String,
      vehicleType: json['vehicleType'] as String,
      driversLicenseNumber: json['driversLicenseNumber'] as String?,
      driversLicenseImgFront: json['driversLicenseImgFront'] as String?,
      driversLicenseImgBack: json['driversLicenseImgBack'] as String?,
      lltpImg: json['lltpImg'] as String?,
      vehicleRegistrationImg: json['vehicleRegistrationImg'] as String?,
      healthCheckDay: json['healthCheckDay'] as String?,
      vehicleInsuranceImgFront: json['vehicleInsuranceImgFront'] as String?,
      vehicleInsuranceImgBack: json['vehicleInsuranceImgBack'] as String?,
      tin: json['tin'] as String?,
      lat: (json['lat'] as num?)?.toInt(),
      lon: (json['lon'] as num?)?.toInt(),
      driver: json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      totalStar: (json['totalStar'] as num?)?.toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$$RegistrationFormModelImplToJson(
        _$RegistrationFormModelImpl instance) =>
    <String, dynamic>{
      'registrationId': instance.registrationId,
      'licensePlate': instance.licensePlate,
      'vehicleType': instance.vehicleType,
      'driversLicenseNumber': instance.driversLicenseNumber,
      'driversLicenseImgFront': instance.driversLicenseImgFront,
      'driversLicenseImgBack': instance.driversLicenseImgBack,
      'lltpImg': instance.lltpImg,
      'vehicleRegistrationImg': instance.vehicleRegistrationImg,
      'healthCheckDay': instance.healthCheckDay,
      'vehicleInsuranceImgFront': instance.vehicleInsuranceImgFront,
      'vehicleInsuranceImgBack': instance.vehicleInsuranceImgBack,
      'tin': instance.tin,
      'lat': instance.lat,
      'lon': instance.lon,
      'driver': instance.driver,
      'totalStar': instance.totalStar,
      'status': instance.status,
    };
