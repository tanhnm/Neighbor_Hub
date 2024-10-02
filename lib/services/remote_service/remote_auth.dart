import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/login_password_screen.dart';
import 'package:flutter_application_1/screens/confirm_otp_screen.dart';
import 'package:flutter_application_1/screens/navbar_screen.dart';
import 'package:http/http.dart' as http;

class RemoteAuth {
  final BuildContext context;
  RemoteAuth({required this.context});
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1/';

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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmOtpScreen(phoneNumber: phone)),
        );
      } else {
        print('Failed to get user. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      print(e);
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
      final response = await http.post(
        Uri.parse(_baseUrl + 'auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Convert body to JSON
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
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
  /// the id of the newly created user.
