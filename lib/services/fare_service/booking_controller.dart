import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/booking.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/driver_list_screen.dart';
import 'package:flutter_application_1/screens/activity_screen.dart';
import 'package:flutter_application_1/utils/api/api.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class BookingController {
  BuildContext context;
  BookingController({required this.context});
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1';

  Future<String?> _getToken() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('token', defaultValue: null);
    return token;
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
        Uri.parse('http://10.0.2.2:8080/api/v1/booking/listAdvanceBooking'),
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
      String currentLocation) async {
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
            '${_baseUrl}/booking/getDriverNearUser?userLat=${lat}&userLon=${lon}'),
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
        'pick: ${pickupLocation}, drop: ${dropoffLocation}, time: ${iso8601String}, distance: ${distance}, userId: ${userId}');

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
        Uri.parse('${_baseUrl}/booking/createBooking'),
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
          MaterialPageRoute(builder: (context) => DriverListScreen()),
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
        'pick: ${pickupLocation}, drop: ${dropoffLocation}, time: ${iso8601String}, distance: ${distance}, userId: ${userId}');

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
        Uri.parse('${_baseUrl}/booking/createAdvanceBooking'),
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
