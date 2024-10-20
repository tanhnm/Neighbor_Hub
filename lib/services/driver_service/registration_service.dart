import 'dart:convert'; // For jsonEncode
import 'package:http/http.dart' as http;

class RegistrationService {
  final String baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/registrationForm'; // Replace with your actual base URL

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
    required String authToken, // Bearer token
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

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(requestBody),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Return the response data
        return jsonDecode(response.body);
      } else {
        // Handle error response
        throw Exception(
            'Failed to create registration form: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error: $e');
    }
  }
}
