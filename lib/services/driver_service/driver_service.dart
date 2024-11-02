import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/domains/driver_model.dart';
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
        Driver driver = Driver.fromJson(response.data);
        print("driver: ${driver.toString()}");
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

  Future<List<Booking>> getAllBookings(int driverId) async {
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
      List jsonResponse = response.data;
      return jsonResponse.map((booking) => Booking.fromJson(booking)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}

class Booking {
  final int bookingDriverId;
  final BookingDetails booking;
  final int driverId;
  final double amount; // Use double for amount

  Booking({
    required this.bookingDriverId,
    required this.booking,
    required this.driverId,
    required this.amount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingDriverId: json['bookingDriverId'],
      booking: BookingDetails.fromJson(json['booking']),
      driverId: json['driverId'],
      amount: json['amount'],
    );
  }
}

class BookingDetails {
  final int bookingId;
  final UserDriver user;
  final Registration? registration; // Make registration nullable
  final double amount;
  final String pickupLocation;
  final String dropoffLocation;
  final String pickupTime;
  final String? dropoffTime; // Make dropoffTime nullable
  final double distance;
  final String status;
  final List<Voucher> vouchers;

  BookingDetails({
    required this.bookingId,
    required this.user,
    this.registration,
    required this.amount,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupTime,
    this.dropoffTime,
    required this.distance,
    required this.status,
    required this.vouchers,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      bookingId: json['bookingId'],
      user: UserDriver.fromJson(json['user']),
      registration: json['registration'] != null
          ? Registration.fromJson(json['registration'])
          : null,
      amount: json['amount'],
      pickupLocation: json['pickupLocation'],
      dropoffLocation: json['dropoffLocation'],
      pickupTime: json['pickupTime'],
      dropoffTime: json['dropoffTime'],
      distance: json['distance'],
      status: json['status'],
      vouchers: (json['vouchers'] as List<dynamic>?)
              ?.map((voucher) => Voucher.fromJson(voucher))
              .toList() ??
          [],
    );
  }
}

class UserDriver {
  final int userId;
  final String username;
  final String phone;
  final String email;

  UserDriver({
    required this.userId,
    required this.username,
    required this.phone,
    required this.email,
  });

  factory UserDriver.fromJson(Map<String, dynamic> json) {
    return UserDriver(
      userId: json['userId'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class Registration {
  final String licensePlate;
  final String vehicleType;

  Registration({
    required this.licensePlate,
    required this.vehicleType,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      licensePlate: json['licensePlate'],
      vehicleType: json['vehicleType'],
    );
  }
}

class Voucher {
  final int voucherId;
  final String code;

  Voucher({
    required this.voucherId,
    required this.code,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      voucherId: json['voucherId'],
      code: json['code'],
    );
  }
}
