


import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';

import '../providers/app_providers.dart';

final bookingServiceProvider = Provider<BookingService>((ref) {
  return BookingService(ref: ref);
});


class BookingService {


  final Ref ref;

  BookingService({required this.ref});

  Future<HttpResponse<void>> createBooking({
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

    final appRepo = ref.read(appApiProvider);

    final token = ref.read(tokenProvider);
    print(requestBody.toString());
    var response = await appRepo
        .createBooking(requestBody, 'Bearer $token');
    return response;
  }


  Future<HttpResponse<void>> createAdvanceBooking({
    required String pickupLocation,
    required String dropoffLocation,
    required int distance,
    required int userId,
    required String currentLocation,
    required String pickupTime,
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

    final appRepo = ref.read(appApiProvider);

    final token = ref.read(tokenProvider);
    print(requestBody.toString());
    var response = await appRepo
        .createAdvanceBooking(requestBody, 'Bearer $token');
    return response;
  }

}