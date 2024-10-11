import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/auth/login_password_screen.dart';
import 'package:flutter_application_1/screens/confirm_otp_screen.dart';
import 'package:flutter_application_1/screens/navbar_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class RemoteAuth {
  final BuildContext context;
  RemoteAuth({required this.context});
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/';

  Future<void> checkPhone({required String phone}) async {
    try {
      final response = await http
          .get(Uri.parse('${_baseUrl}user/getByPhoneNumber/${phone}'));

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPasswordScreen(phoneNumber: phone)),
        );
      } else if (response.body == "User does not exist") {
        print('User does not exist');
        print('phone: ${phone}');
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
        title: Text('${e}'),
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
        Uri.parse(_baseUrl + 'OTP/start-verification')
            .replace(queryParameters: {
          'toPhoneNumber': '+84$phoneCut', // Append the country code
        }),
        headers: {'Content-Type': 'application/json'},
        body: null, // Convert body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Send OTP successful');
        print('Response: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmOtpScreen(phoneNumber: phone)),
        );
      } else {
        print('Failed to send OTP. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while sending OTP: $e');
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
        Uri.parse(_baseUrl + 'OTP/check-verification')
            .replace(queryParameters: {
          'toPhoneNumber': '+84$phoneCut',
          'code': code, // Append the country code
        }),
        headers: {'Content-Type': 'application/json'},
        body: null, // Convert body to JSON
      );
      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Verify OTP successful');
        print('Response: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterScreen(
                    phone: phone,
                  )),
        );
      } else {
        print('Failed to verify OTP. Status code: ${response.statusCode}');
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title:
              Text('Failed to verify OTP. Status code: ${response.statusCode}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while verify OTP: $e');
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
    print('phone: $phone');
    print('password: $password');
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + 'auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Convert body to JSON
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        // Assuming the token is in the response body, modify if your response format differs
        var jsonResponse = jsonDecode(response.body);
        print("jsonResponse: ${jsonResponse['refresh_token']}");
        String token = jsonResponse['access_token'];
        String refreshToken = jsonResponse['refresh_token'];

        // Open a Hive box (you can create the box during app initialization)
        var box = await Hive.openBox('authBox');
        // Open a Hive box
        var userBox = await Hive.openBox<User>('users');
        User user = User.fromJson(jsonResponse['user']);

        // Store the token in Hive
        await box.put('token', token);
        // Store the user
        await userBox.put('user', user);
        // Retrieve the user
        User? retrievedUser = userBox.get('user');
        print(
            'Retrieved User: ${retrievedUser?.username}'); // Output: Retrieved User: Huynh Nguyen Minh Tan

        // Navigate to the bottom nav screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      } else if (response.body == "Wrong password") {
        print('Wrong password');
      } else {
        print('Failed to get user. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print(e);
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
        Uri.parse(_baseUrl + 'auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Convert body to JSON
      );

      // Check the response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Sign-up successful');
        print('Response: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPasswordScreen(phoneNumber: phone)),
        );
      } else {
        print('Failed to sign up. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while signing up: $e');
    }
  }
}
