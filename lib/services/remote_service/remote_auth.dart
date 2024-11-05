import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/router.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:flutter_application_1/features/auth/login_password_screen.dart';
import 'package:flutter_application_1/features/temp_screen/confirm_otp_screen_new.dart';
import 'package:flutter_application_1/features/temp_screen/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';
import 'package:dio/dio.dart';

import '../../common/routes.dart';


class RemoteAuth {
  final BuildContext context;
  RemoteAuth({required this.context});
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/';

  Future<void> checkPhone({required String phone}) async {
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}user/getByPhoneNumber/$phone'));

      if (response.statusCode == 200) {
        if(context.mounted) {
          Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPasswordScreen(phoneNumber: phone)),
        );
        }
      } else if (response.body == "User does not exist") {
        sendSMSOTP(phone: phone);
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title: Text('Error response: ${response.body}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('$e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> sendSMSOTP({
    required String phone,
  }) async {
    String phoneCut = phone.substring(1);
    // Create the request body
    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse('${_baseUrl}OTP/start-verification')
            .replace(queryParameters: {
          'toPhoneNumber': '+84$phoneCut', // Append the country code
        }),
        headers: {'Content-Type': 'application/json'},
        body: null, // Convert body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmOtpScreenNew(phoneNumber: phone)),
        );
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title:
              Text('Failed to send OTP. Status code: ${response.statusCode}'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('$e'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> verifySMSOTP({
    required String phone,
    required String code,
  }) async {
    String phoneCut = phone.substring(1);
    // Create the request body
    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse('${_baseUrl}OTP/check-verification')
            .replace(queryParameters: {
          'toPhoneNumber': '+84$phoneCut',
          'code': code, // Append the country code
        }),
        headers: {'Content-Type': 'application/json'},
        body: null, // Convert body to JSON
      );
      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterScreen(
                    phone: phone,
                  )),
        );
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title:
              Text('Failed to verify OTP. Status code: ${response.statusCode}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('$e'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> signIn({
    required String phone,
    required String password,
  }) async {
    Map<String, String> requestBody = {
      'phoneOrEmail': phone,
      'password': password,
    };
    try {
      final response = await _dio.post(
        '${_baseUrl}auth/login',
        data: requestBody,
      );

      if (response.statusCode == 200) {
        String token = response.data['access_token'];
        String refreshToken = response.data['refresh_token'];

        var box = Hive.box('authBox');
        // Open a Hive box
        var userBox = Hive.box<UserModel>('users');
        UserModel user = UserModel.fromJson(response.data['user']);

        await box.put('is_logged_in', true); // Mark the user as logged in

        // Store the token in Hive
        await box.put('token', token);
        // Store the user
        await userBox.put('user', user);
        // Retrieve the user
        UserModel? retrievedUser = userBox.get('user');
        // Navigate to the bottom nav screen
        context.pushNamed(Routes.home);
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title: Text('${jsonDecode(response.data)['message']}'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('$e'),
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> signUp({
    required String phone,
    required String email,
    required String password,
    required String username,
  }) async {
    // Create the request body
    Map<String, String> requestBody = {
      'phone': phone,
      'email': email,
      'password': password,
      'username': username,
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse('${_baseUrl}auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Convert body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPasswordScreen(phoneNumber: phone)),
        );
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title: Text('Failed to sign up. Status code: ${response.statusCode}'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('$e'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }
}
