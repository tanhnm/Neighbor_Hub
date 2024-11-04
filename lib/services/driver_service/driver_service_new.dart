

// Provider for DriverService
import 'dart:convert';

import 'package:flutter_application_1/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final driverServiceProvider = Provider<DriverService>((ref) {
  return DriverService(ref: ref);
});

class DriverService {

  final Ref ref;

  DriverService({required this.ref});



  Future<void> getDriverByPhoneNumber(String phoneNumber) async {
    try {
      final appRepo = ref.read(appApiProvider);
      final response = await appRepo.getDriverByPhoneNumber(phoneNumber);
      final box = await Hive.openBox('authBox');
      await box.putAll({
        'driverId': response.driverId,
        'is_driver': true,
      });
        } catch (e) {
      print('Error fetching driver by phone number: $e');
    }
  }

  Future<bool> activateDriver({
    required int registrationId,
    required double lat,
    required double lon,
  }) async {
    try {
      // Get the token from the token provider
      final token = ref.read(tokenProvider);

      // Prepare the request body
      Map<String, dynamic> requestBody = {
        "registrationId": registrationId,
        "lat": lat,
        "lon": lon,
      };

      // Call the Retrofit API method
      final appApi = ref.read(appApiProvider);
      final response = await appApi.activateDriver(
        requestBody,
        'Bearer $token',
      );

      if (response.response.statusCode == 200 && response.data == "Is Active") {
        final box = await Hive.openBox('authBox');
        await box.put('is_active', true);
        return true;
      } else {
        throw Exception('Failed to activate driver');
      }
    } catch (e) {
      print('Error activating driver: $e');
      return false;
    }
  }

}