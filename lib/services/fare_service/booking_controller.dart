import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/booking.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/driver_list_screen.dart';
import 'package:flutter_application_1/screens/activity_screen.dart';
import 'package:flutter_application_1/utils/api/api.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class BookingController {
  Dio _dio = Dio();

  BuildContext context;
  BookingController({required this.context});
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1';

  Future<String?> _getToken() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('token', defaultValue: null);
    return token;
  }

  // Method to fetch bookings by user ID
  Future<http.Response> getBookingsByUserId(int userid) async {
    try {
      print('$_baseUrl/booking/getBookingByUserId/${userid}');

      // Call the API to get bookings
      final response = await http.get(
        Uri.parse('$_baseUrl/booking/getBookingByUserId/${userid}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Check for response status
      if (response.statusCode == 200) {
        print(response.body);
        return response; // Return the response if successful
      } else {
        print('$_baseUrl/booking/getBookingByUserId/${userid}');
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Failed to load bookings');
    }
  }

  Future<List<Booking>> getBookingAdvanceList() async {
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
        List<dynamic> responseData = json.decode(response.body);

        // Convert the list of JSON objects to a list of Booking objects
        List<Booking> bookings = responseData.map((json) {
          return Booking.fromJson(json);
        }).toList();

        return bookings;
      } else {
        // Handle any errors
        print('Failed to load bookings. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching bookings: $e');
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
        print('No token found');
        return [];
      }
      double lon = double.parse(currentLocation.split(',')[0]);
      double lat = double.parse(currentLocation.split(',')[1]);
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/booking/getDriverNearUser?userLat=$lat&userLon=$lon&bookingId=${booking['bookingId']}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print('Driver(s) retrieved successfully');
        print('Response: ${response.body}');
        if (response.statusCode == 200) {
          // Parse the response body as JSON and cast it to the correct type
          List<dynamic> data = json.decode(response.body);

          // Cast each item in the list to Map<String, dynamic>
          return data
              .map((driverInfo) => driverInfo['driver'] as Map<String, dynamic>)
              .toList();
        } else {
          // Handle error response
          print('Failed to load driver data');
        }
      } else {
        print('Failed to get drivers. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<Map<String, dynamic>> addDriverAmount({
    required int driverId,
    required double amount,
    required int bookingId,
  }) async {
    final String url = '$baseUrl/booking/addDriverAmount';
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
        print('No token found');
        return {};
      }
      final response = await http.post(
        Uri.parse(url),
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

    print(
        'pick: $pickupLocation, drop: $dropoffLocation, time: $iso8601String, distance: $distance, userId: $userId');

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
        print('No token found');
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
        print('Booking created successfully');
        print('Response: ${response.body}');
        var box = await Hive.openBox('locationBox');
        await box.put('currentLocation', currentLocation);
        print(box.get('currentLocation'));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActivityScreen()),
        );
      } else {
        print('Failed to create booking. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating booking: $e');
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

    print(
        'pick: $pickupLocation, drop: $dropoffLocation, time: $iso8601String, distance: $distance, userId: $userId');

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
        print('No token found');
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
        print('Booking created successfully');
        print('Response: ${response.body}');
        var box = await Hive.openBox('locationBox');
        await box.put('currentLocation', currentLocation);
        print(box.get('currentLocation'));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActivityScreen()),
        );
      } else {
        print('Failed to create booking. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating booking: $e');
    }
  }
}
