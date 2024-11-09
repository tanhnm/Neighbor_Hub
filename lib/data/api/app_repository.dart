import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/restaurants.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/domains/freezed/booking_model.dart';
import 'package:flutter_application_1/domains/freezed/booking_voucher_model.dart';
import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:flutter_application_1/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio_provider.dart';

part 'app_repository.g.dart';

class AppRepository {
  AppRepository({required this.client});

  final Dio client;

  Future<List<BookingDetailModel>> getBookingDetails(int userid,
      {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'api/v1/booking/getBookingByUserId/$userid',
    ).toString();

    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    return list.map((e) => BookingDetailModel.fromJson(e)).toList();
  }

  Future<List<RegistrationFormModel>> getDrivers(
      String currentLocation, int bookingId,
      {CancelToken? cancelToken}) async {
    double lon = double.parse(currentLocation.split(',')[1]);
    double lat = double.parse(currentLocation.split(',')[0]);

    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'api/v1/booking/getDriverNearUser',
      queryParameters: {
        'userLat': lat.toString(),
        'userLon': lon.toString(),
        'bookingId': bookingId.toString(),
      },
    ).toString();

    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    print(list);
    return list.map((e) => RegistrationFormModel.fromJson(e)).toList();
  }

  Future<List<RegistrationFormModel>> getAllRegistrationFormsById(
      int driverId, String token,
      {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: '/api/v1/registrationForm/getAllRegistrationForm/$driverId',

    ).toString();

    Options options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final response =
        await client.get(url, cancelToken: cancelToken, options: options);
    final List list = response.data;
    print(list);
    return list.map((e) => RegistrationFormModel.fromJson(e)).toList();
  }

  Future<List<BookingModel>> getAllBookingsByDriverId(
      int driverId, String token,
      {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'driver/getAllBooking/$driverId',

    ).toString();

    Options options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final response =
    await client.get(url, cancelToken: cancelToken, options: options);
    final List list = response.data;
    return list.map((e) => BookingModel.fromJson(e)).toList();
  }

  Future<List<VoucherModel>> getAllVouchers(
      {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'api/v1/voucher/viewAllVoucher',
    ).toString();

    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    return list.map((e) => VoucherModel.fromJson(e)).toList();
  }

  //note: add later booking controller: addDriver
  Future<void> addDriver(
      {CancelToken? cancelToken,required String token,  required int registrationId,
        required int bookingId,}
      ) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: '/api/v1/booking/addDriver',
    ).toString();

    final Map<String, dynamic> requestBody = {
      "registrationFormId": registrationId,
      "bookingId": bookingId,
    };

    Options options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final response =
    await client.post(url, data: requestBody, cancelToken: cancelToken, options: options);
    final List list = response.data;
    print(list);
    return response.data;
    // return list.map((e) => RegistrationFormModel.fromJson(e)).toList();
  }

  //note: add later booking controller: addDriverAmount
  Future<void> addDriverAmount(

      {CancelToken? cancelToken,
        required int driverId,
        required double amount,
        required int bookingId,required String token,}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: '/api/v1/booking/addDriverAmount',
    ).toString();

    final Map<String, dynamic> requestBody = {
      "driverId": driverId,
      "amount": amount,
      "bookingId": bookingId,
    };
    Options options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final response =
    await client.post(url, data: requestBody, cancelToken: cancelToken, options: options);
    final List list = response.data;
    print(list);
    return response.data;
    // return list.map((e) => RegistrationFormModel.fromJson(e)).toList();
  }


}

@Riverpod(keepAlive: true)
AppRepository appRepository(Ref ref) => AppRepository(
      client: ref.watch(dioProvider),
    );
