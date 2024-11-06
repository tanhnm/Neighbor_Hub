// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_voucher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingVoucherElementModelImpl _$$BookingVoucherElementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingVoucherElementModelImpl(
      id: (json['id'] as num).toInt(),
      booking: json['booking'] as String?,
      voucher: json['voucher'] as String,
      used: json['used'] as bool,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookingVoucherElementModelImplToJson(
        _$BookingVoucherElementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking': instance.booking,
      'voucher': instance.voucher,
      'used': instance.used,
      'user': instance.user,
    };

_$VoucherModelImpl _$$VoucherModelImplFromJson(Map<String, dynamic> json) =>
    _$VoucherModelImpl(
      voucherId: (json['voucherId'] as num).toInt(),
      code: json['code'] as String,
      description: json['description'] as String,
      discount: (json['discount'] as num).toInt(),
      expiryDate: json['expiryDate'] as String,
      status: json['status'] as bool?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userVouchers: (json['userVouchers'] as List<dynamic>?)
          ?.map((e) =>
              BookingVoucherElementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingVouchers: (json['bookingVouchers'] as List<dynamic>?)
          ?.map((e) =>
              BookingVoucherElementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VoucherModelImplToJson(_$VoucherModelImpl instance) =>
    <String, dynamic>{
      'voucherId': instance.voucherId,
      'code': instance.code,
      'description': instance.description,
      'discount': instance.discount,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'bookings': instance.bookings,
      'userVouchers': instance.userVouchers,
      'bookingVouchers': instance.bookingVouchers,
    };
