import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:flutter_application_1/domains/freezed/booking_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DriverService {
  final _dio = Dio(); // Create an instance of Dio

  final String baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1';

  Future<String?> _getToken() async {
    var box = Hive.box('authBox');
    return box.get('token', defaultValue: null);
  }

  Future<void> getDriverByPhoneNumber(String phoneNumber) async {
    try {
      final response =
          await _dio.get('$baseUrl/driver/getDriverByPhoneNumber/$phoneNumber');

      if (response.statusCode == 200) {
        // Parse the response to create a Driver instance
        DriverModel driver = DriverModel.fromJson(response.data);
        print("driver: ${driver.toString()}");
        print(response.data['driverId']);
        var box = Hive.box('authBox');
        box.put('driverId', response.data['driverId']);
        box.put('is_driver', true);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> activateDriver(
      {required int registrationId,
      required double lat,
      required double lon}) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        return false;
      }
      Map<String, dynamic> requestBody = {
        "registrationId": registrationId,
        "lat": lat,
        "lon": lon,
      };

      final response =
          await http.put(Uri.parse('$baseUrl/registrationForm/isActive'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        if (response.body == "Is Active") {
          return true;
        }
      } else {
        throw Exception('Failed to activate driver');
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<bool> deactivateDriver(int registrationId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        return false;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/registrationForm/unActive/$registrationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        if (response.body == "UnActive") {
          return true;
        }
      } else {
        throw Exception('Failed to deactivate driver');
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<List<BookingModel>> getAllBookings(int driverId) async {
    String? token = await _getToken();
    if (token == null) {
      return [];
    }

    final response = await _dio.get('$baseUrl/driver/getAllBooking/$driverId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));

    if (response.statusCode == 200) {
      return bookingModelFromJson(response.data);
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}


