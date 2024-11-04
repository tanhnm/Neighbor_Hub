import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/booking_model.dart';
import 'package:flutter_application_1/features/temp_screen/activity_screen.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class BookingController {
  final Dio _dio = Dio();

  BuildContext? context;
  BookingController({this.context});
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1';

  Future<String?> _getToken() async {
    var box = Hive.box('authBox');
    String? token = box.get('token', defaultValue: null);
    return token;
  }

  // Method to fetch bookings by user ID
  Future<List<dynamic>> getBookingsByUserId(int userid) async {
    try {
      // Call the API to get bookings
      final response =
          await _dio.get('$_baseUrl/booking/getBookingByUserId/$userid');
      print('$_baseUrl/booking/getBookingByUserId/$userid');
      // Check for response status
      if (response.statusCode == 200) {
        return response.data; // Return the response if successful
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Failed to load bookings');
    }
  }

  Future<List<BookingModel>> getBookingAdvanceList() async {
    try {
      // Get the token
      // String? token = await _getToken();

      // // Make sure the token exists
      // if (token == null) {
      //   print('No token found');
      //   return [];
      // }
      // Make the API GET request
      final response = await http.get(
        Uri.parse('$_baseUrl/booking/listAdvanceBooking'),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        // List<dynamic> responseData = json.decode(response.body);
        //
        // // Convert the list of JSON objects to a list of Booking objects
        // List<Booking> bookings = responseData.map((json) {
        //   return Booking.fromJson(json);
        // }).toList();
        return bookingModelFromJson(response.body);

        // return bookings;
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: const Text('Error'),
        );
        // Handle any errors
        return [];
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getDriverNearUser(
      String currentLocation, Map<String, dynamic> booking) async {
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        return [];
      }
      double lon = double.parse(currentLocation.split(',')[1]);
      double lat = double.parse(currentLocation.split(',')[0]);
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/booking/getDriverNearUser?userLat=$lat&userLon=$lon&bookingId=${booking['bookingId']}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          // Parse the response body as JSON and cast it to the correct type
          List<dynamic> data = json.decode(response.body);

          // Cast each item in the list to Map<String, dynamic>
          return data
              .map((driverInfo) => {
                    "driver": driverInfo['driver'],
                    "registrationId": driverInfo['registrationId']
                  })
              .toList();
        } else {
          // Handle error response
          toastification.show(
            context: context,
            style: ToastificationStyle.flat,
            title: const Text('Error something went wrong!'),
          );
        }
      } else {}
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
      return [];
    }
    return [];
  }

  Future<Map<String, dynamic>> getDriverAmount(
      int driverId, int bookingId) async {
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        return {};
      }
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/booking/getDriverAmount?driverId=$driverId&bookingId=$bookingId'),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Return the response data
        Map<String, dynamic> data;
        return data = json.decode(response.body);
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: const Text('Error'),
        );
        // Handle error response
        return {};
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
      return {};
    }
  }

  Future<Map<String, dynamic>> addDriver({
    required int registrationId,
    required int bookingId,
  }) async {
    final Map<String, dynamic> requestBody = {
      "registrationFormId": registrationId,
      "bookingId": bookingId,
    };
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        throw Exception('No token found');
      }
      final response = await http.post(
        Uri.parse('$_baseUrl/booking/addDriver'),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Return the response data
        Map<String, dynamic> data;
        return data = json.decode(response.body);
      } else {
        // Handle error response
        throw Exception('Failed to add driver: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio error
      throw Exception('addDriver error: $e');
    }
  }

  Future<Map<String, dynamic>> addDriverAmount({
    required int driverId,
    required double amount,
    required int bookingId,
  }) async {
    final Map<String, dynamic> requestBody = {
      "driverId": driverId,
      "amount": amount,
      "bookingId": bookingId,
    };
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        return {};
      }
      final response = await http.post(
        Uri.parse('$_baseUrl/booking/addDriverAmount'),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Return the response data
        Map<String, dynamic> data;
        return data = json.decode(response.body);
      } else {
        // Handle error response
        throw Exception('Failed to add driver amount: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio error
      throw Exception('Dio error: $e');
    }
  }

  Future<String> createQrCodePayment(int bookingId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        return '';
      }
      final response = await http.post(
        Uri.parse('$_baseUrl/booking/createQrCode/$bookingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '';
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
      return '';
    }
  }

  Future<void> createBooking({
    required String pickupLocation,
    required String dropoffLocation,
    required int distance,
    required int userId,
    required String currentLocation,
  }) async {
    // Get the current date and time
    DateTime now = DateTime.now(); // Convert to UTC
    // Format the date to ISO 8601 format
    String iso8601String = now.toIso8601String();

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      "pickupLocation": pickupLocation,
      "dropoffLocation": dropoffLocation,
      "pickupTime": iso8601String,
      "distance": distance,
      "userId": userId,
    };

    // Send the POST request
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        return;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/booking/createBooking'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody), // Convert the request body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        var box = Hive.box('locationBox');
        await box.put('currentLocation', currentLocation);
        Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => const ActivityScreen()),
        );
      } else {}
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
    }
  }

  Future<void> createBookingAdvance({
    required String pickupLocation,
    required String dropoffLocation,
    required int distance,
    required int userId,
    required String currentLocation,
    required String pickupTime,
  }) async {
    // Get the current date and time
    DateTime now = DateTime.now().toUtc(); // Convert to UTC
    // Format the date to ISO 8601 format
    String iso8601String = now.toIso8601String();

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      "pickupLocation": pickupLocation,
      "dropoffLocation": dropoffLocation,
      "pickupTime": pickupTime,
      "distance": distance,
      "userId": userId,
    };

    // Send the POST request
    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        return;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/booking/createAdvanceBooking'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody), // Convert the request body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        var box = Hive.box('locationBox');
        await box.put('currentLocation', currentLocation);
        Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => const ActivityScreen()),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
    }
  }
}
