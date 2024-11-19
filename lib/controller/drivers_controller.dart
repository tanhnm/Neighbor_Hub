import 'package:dio/dio.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:flutter_application_1/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/api/app_repository.dart';
import '../providers/user_provider.dart';

part 'drivers_controller.g.dart';


@riverpod
class DriversController extends _$DriversController {

  @override
  FutureOr<List<RegistrationFormModel>> build(int bookingId) async {
    String token = ref.read(tokenProvider);
    if(token == '') return [];
    return fetchDrivers(bookingId);
  }

  Future<List<RegistrationFormModel>> fetchDrivers(int bookingId) async {
    try {

      final appRepository = ref.watch(appRepositoryProvider);


      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ref.read(tokenProvider)}',
      };

      appRepository.client.options.headers = headers;
      var box = Hive.box('locationBox');
      String userLocation = box.get('currentLocation') ?? '';

      if (userLocation.isNotEmpty) {

        final cancelToken = CancelToken();
        List<RegistrationFormModel> listReg = await appRepository.getDrivers(userLocation, bookingId, cancelToken: cancelToken);
        print(listReg);
        return listReg;
      } else {
        await _getCurrentLocationAndUpdate();
        return fetchDrivers(bookingId);
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
  Future<void> _getCurrentLocationAndUpdate() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        String userLocation = '${position.latitude},${position.longitude}';

        var box = Hive.box('locationBox');
        await box.put('currentLocation', userLocation);
      } else {
        throw Exception(
            "Location permission denied. Please enable it in settings.");
      }
    } catch (e) {
      throw Exception("Error retrieving location: ${e.toString()}");
    }
  }
}

@Riverpod(keepAlive: true)
class BookingDriverController extends _$BookingDriverController {
  @override
    FutureOr<List<BookingDetailModel>> build() async {
    return fetchBookingDriver();
  }
  Future<List<BookingDetailModel>> fetchBookingDriver() async {


      final appRepository = ref.watch(appRepositoryProvider);
      final driverId = ref.read(driverProvider).value!;
      final cancelToken = CancelToken();
      return appRepository.getBookingsOfDriver(
        driverId,
        cancelToken: cancelToken,
      );
  }

}