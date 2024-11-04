import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/restaurants.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio_provider.dart';

part 'app_repository.g.dart';

class AppRepository {
  AppRepository({required this.client});

  final Dio client;

  Future<List<BookingDetailModel>> getBookingDetails( int userid, {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'api/v1/booking/getBookingByUserId/$userid',
    ).toString();


    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    return list.map((e) => BookingDetailModel.fromJson(e)).toList();
  }


  Future<List<RegistrationFormModel>> getDrivers(String currentLocation,int bookingId,{CancelToken? cancelToken} ) async {

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
    String? token = await _getToken();
    if (token == null) {
      return [];
    }
    // Add headers including the Authorization header with the Bearer token
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(url, cancelToken: cancelToken, options: Options(headers: headers));
    final List list = response.data;
    return list.map((e) => RegistrationFormModel.fromJson(e)).toList();
  }

  Future<String?> _getToken() async {
    var box = Hive.box('authBox');
    String? token = box.get('token', defaultValue: null);
    return token;
  }
}

@Riverpod(keepAlive: true)
AppRepository appRepository(Ref ref) => AppRepository(
  client: ref.watch(dioProvider),
);