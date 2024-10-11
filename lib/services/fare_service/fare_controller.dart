import 'dart:convert'; // For jsonEncode
import 'dart:io';
import 'package:flutter_application_1/model/trip.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/remote_service/remote_auth.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class FareController {
  final BuildContext context;
  FareController({required this.context});
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/';

  Future<String?> _getToken() async {
    var box = await Hive.openBox('authBox');
    String? token = box.get('token', defaultValue: null);
    return token;
  }

  // Method to get fare based on travel time
  Future<List<Trip>> getFare(
      {required double travelTime,
      required double distance,
      List<String>? listVoucher}) async {
    Map<String, dynamic> requestBody = {
      "distance": distance.toString(),
      'travelTime': travelTime.toString(),
      "listVoucher": listVoucher ?? []
    };

    try {
      // Get the token
      String? token = await _getToken();

      // Make sure the token exists
      if (token == null) {
        print('No token found');
        return [];
      }

      // Get the current UTC time
      DateTime currentTime = DateTime.now().toUtc();

      // Add the given seconds to the current time
      DateTime newDateTime =
          currentTime.add(Duration(seconds: travelTime.toInt()));

      // Format to ISO 8601 with milliseconds and 'Z' for UTC
      String formattedDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(newDateTime);

      print(formattedDate); // The time after adding 752 seconds to now in UTC

      print("formattedDate: $formattedDate"); // Output in ISO 8601 format

      print('TOKEN HEADERS $token');

      final response = await http.post(
        Uri.parse(_baseUrl + 'booking/calculateFare'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },

        body: jsonEncode(requestBody), // Convert body to JSON
      );

      if (response.statusCode == 200) {
        print('Fare calculation response: ${response.body}');
        List<dynamic> jsonResponse = json.decode(response.body);
        // Map the JSON response to a list of Trip objects
        List<Trip> trips =
            jsonResponse.map((trip) => Trip.fromJson(trip)).toList();
        return trips;
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: Text(
              'Failed to calculate fare. Status code: ${response.statusCode}'),
        );
        print('Failed to calculate fare. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while calculating fare: $e');
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error occurred: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      throw e;
    }

    return [];
  }

  // Method to get all fare types (you can modify based on your API)
  Future<void> getFareTypes() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + 'fare/types'),
      );

      if (response.statusCode == 200) {
        print('Fare types response: ${response.body}');
        // Process the response to display the fare types
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: Text('Fare types: ${response.body}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else {
        print(
            'Failed to fetch fare types. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching fare types: $e');
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error occurred: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      throw e;
    }
  }

  // Method to update a fare based on some identifier
  Future<void> updateFare(
      {required String fareId, required double newFare}) async {
    Map<String, dynamic> requestBody = {
      'fareId': fareId,
      'newFare': newFare,
    };

    try {
      final response = await http.put(
        Uri.parse(_baseUrl + 'fare/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Convert body to JSON
      );

      if (response.statusCode == 200) {
        print('Fare update response: ${response.body}');
        // You can display the updated fare details here
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: Text('Fare updated: ${response.body}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else {
        print('Failed to update fare. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while updating fare: $e');
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error occurred: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      throw e;
    }
  }
}
