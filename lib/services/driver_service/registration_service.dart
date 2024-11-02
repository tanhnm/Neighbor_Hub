import 'dart:convert'; // For jsonEncode
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class RegistrationService {
  final String baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/registrationForm'; // Replace with your actual base URL

  Future<String?> _getToken() async {
    var box = Hive.box('authBox');
    return box.get('token', defaultValue: null);
  }

  Future<List<Map<String, dynamic>>> getAllRegistrationForms(
      int driverId) async {
    final String url = '$baseUrl/getAllRegistrationForm/$driverId';

    try {
      String? token = await _getToken();
      if (token == null) {
        print('No token found');
        return [];
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Decode and return the list of registration forms
        List<dynamic> data = jsonDecode(response.body);
        print("Retrieved registration forms: $data");
        return data.map((form) => form as Map<String, dynamic>).toList();
      } else {
        // Handle error response
        print('Failed to retrieve registration forms: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error: $e');
    }
    return [];
  }

  Future<Map<String, dynamic>> createRegistrationForm({
    required int driverId,
    required String licensePlate,
    required String vehicleType,
    required String driversLicenseNumber,
    required String driversLicenseImgFront,
    required String driversLicenseImgBack,
    required String lltpImg,
    required String vehicleRegistrationImg,
    required String healthCheckDay,
    required String vehicleInsuranceImgFront,
    required String vehicleInsuranceImgBack,
    required String tin,
  }) async {
    final String url = '$baseUrl/createRegisform';

    // Create request body
    final Map<String, dynamic> requestBody = {
      'driverId': driverId,
      'licensePlate': licensePlate,
      'vehicleType': vehicleType,
      'driversLicenseNumber': driversLicenseNumber,
      'driversLicenseImgFront': driversLicenseImgFront,
      'driversLicenseImgBack': driversLicenseImgBack,
      'lltpImg': lltpImg,
      'vehicleRegistrationImg': vehicleRegistrationImg,
      'healthCheckDay': healthCheckDay,
      'vehicleInsuranceImgFront': vehicleInsuranceImgFront,
      'vehicleInsuranceImgBack': vehicleInsuranceImgBack,
      'tin': tin,
    };

    print('requestBody: $requestBody');

    try {
      String? token = await _getToken();
      if (token == null) {
        print('No token found');
        return {};
      }
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Return the response data
        var data = jsonDecode(response.body);
        print("Create registration form successful: $data");
        return jsonDecode(response.body);
      } else {
        // Handle error response
        print('Failed to create registration form: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error: $e');
    }
    return {};
  }
}
