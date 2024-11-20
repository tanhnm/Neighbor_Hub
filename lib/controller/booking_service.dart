import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';

import '../data/api/app_repository.dart';
import '../domains/trip.dart';
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
    required int price,
    required String currentLocation,
  }) async {
    // Get the current date and time
    DateTime now = DateTime.now(); // Convert to UTC
    // Format the date to ISO 8601 format
    String iso8601String = now.toIso8601String();

    print('cac $price');
    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      "pickupLocation": pickupLocation,
      "dropoffLocation": dropoffLocation,
      "pickupTime": iso8601String,
      "distance": distance,
      "userId": userId,
      "price": price,
    };

    final appRepo = ref.read(appApiProvider);

    final token = ref.read(tokenProvider);
    print(requestBody.toString());
    print('token: $token');
    var response = await appRepo.createBooking(requestBody, 'Bearer $token');
    return response;
  }

  Future<HttpResponse<void>> createAdvanceBooking({
    required String pickupLocation,
    required String dropoffLocation,
    required int distance,
    required int userId,
    required int price,
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
      "price": price,
    };

    final appRepo = ref.read(appApiProvider);

    final token = ref.read(tokenProvider);
    print(requestBody.toString());
    var response =
        await appRepo.createAdvanceBooking(requestBody, 'Bearer $token');
    return response;
  }

  Future<HttpResponse<void>> deleteUser() async {
    // Get the current date and time
    DateTime now = DateTime.now(); // Convert to UTC
    // Format the date to ISO 8601 format

    final appRepo = ref.read(appApiProvider);
    final user = ref.watch(userProvider);

    var response = await appRepo.deleteUser(user.value!.userId.toString());
    return response;
  }

  Future<int> addDriver(
    int registrationId,
    int bookingId,
  ) async {
    final appRepository = ref.watch(appRepositoryProvider);

    final token = ref.read(tokenProvider);
    final user = ref.read(userProvider);
    final response = await appRepository.addDriver(
        token: token,
        registrationId: registrationId,
        bookingId: bookingId,
        userId: user.value!.userId);
    return response;
  }

  Future<void> addDriverAmount(
    String token,
    int driverId,
    double amount,
    int bookingId,
  ) async {
    final appRepository = ref.watch(appRepositoryProvider);

    final token = ref.read(tokenProvider);
    final response = await appRepository.addDriverAmount(
        token: token, driverId: driverId, bookingId: bookingId, amount: amount);
    return response;
  }


  Future<int> putBookingComplete(
      int registrationId,
      int bookingId,
      ) async {
    final appRepository = ref.watch(appRepositoryProvider);

    final token = ref.read(tokenProvider);
    final user = ref.read(userProvider);
    final response = await appRepository.putBookingComplete(
        token: token,
        registrationId: registrationId,
        bookingId: bookingId);
    return response;
  }

  Future<BookingDetailModel> addDriverRequest(
    int userId,
    int registrationFormId,
    int bookingId,
  ) async {
    final appRepository = ref.watch(appRepositoryProvider);
    final response = await appRepository.addDriverRequest(
        userId, registrationFormId, bookingId);
    return response;
  }

  Future<List<Trip>> getFare(double travelTime, double distance) async {
    final appRepository = ref.watch(appRepositoryProvider);
    final token = ref.read(tokenProvider);
    var response = await appRepository.getFare(
        token: token, travelTime: travelTime, distance: distance);
    return response;
  }
}
