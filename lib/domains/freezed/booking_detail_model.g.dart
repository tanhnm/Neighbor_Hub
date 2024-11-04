// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingDetailModelImpl _$$BookingDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingDetailModelImpl(
      bookingId: (json['bookingId'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      registration: json['registration'] == null
          ? null
          : RegistrationFormModel.fromJson(
              json['registration'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toInt(),
      pickupLocation: json['pickupLocation'] as String,
      dropoffLocation: json['dropoffLocation'] as String,
      pickupTime: json['pickupTime'] as String,
      dropoffTime: json['dropoffTime'] as String?,
      distance: (json['distance'] as num).toInt(),
      status: json['status'] as String,
      vouchers: (json['vouchers'] as List<dynamic>?)
          ?.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      qrPayment: json['qrPayment'] as String?,
    );

Map<String, dynamic> _$$BookingDetailModelImplToJson(
        _$BookingDetailModelImpl instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'user': instance.user,
      'registration': instance.registration,
      'amount': instance.amount,
      'pickupLocation': instance.pickupLocation,
      'dropoffLocation': instance.dropoffLocation,
      'pickupTime': instance.pickupTime,
      'dropoffTime': instance.dropoffTime,
      'distance': instance.distance,
      'status': instance.status,
      'vouchers': instance.vouchers,
      'qrPayment': instance.qrPayment,
    };
