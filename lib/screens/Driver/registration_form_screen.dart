import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/driver_service/registration_service.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({Key? key}) : super(key: key);

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final TextEditingController driverIdController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController driversLicenseNumberController =
      TextEditingController();
  final TextEditingController driversLicenseImgFrontController =
      TextEditingController();
  final TextEditingController driversLicenseImgBackController =
      TextEditingController();
  final TextEditingController lltpImgController = TextEditingController();
  final TextEditingController vehicleRegistrationImgController =
      TextEditingController();
  final TextEditingController healthCheckDayController =
      TextEditingController();
  final TextEditingController vehicleInsuranceImgFrontController =
      TextEditingController();
  final TextEditingController vehicleInsuranceImgBackController =
      TextEditingController();
  final TextEditingController tinController = TextEditingController();

  String authToken = 'your_auth_token'; // Replace with your actual token

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: driverIdController,
                decoration: const InputDecoration(labelText: 'Driver ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Driver ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: licensePlateController,
                decoration: const InputDecoration(labelText: 'License Plate'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the License Plate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: vehicleTypeController,
                decoration: const InputDecoration(labelText: 'Vehicle Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Vehicle Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: driversLicenseNumberController,
                decoration: const InputDecoration(
                    labelText: 'Driver\'s License Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Driver\'s License Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: driversLicenseImgFrontController,
                decoration: const InputDecoration(
                    labelText: 'Driver\'s License Image Front URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the front image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: driversLicenseImgBackController,
                decoration: const InputDecoration(
                    labelText: 'Driver\'s License Image Back URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the back image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lltpImgController,
                decoration: const InputDecoration(labelText: 'LLTP Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the LLTP image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: vehicleRegistrationImgController,
                decoration: const InputDecoration(
                    labelText: 'Vehicle Registration Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the vehicle registration image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: healthCheckDayController,
                decoration: const InputDecoration(
                    labelText: 'Health Check Day (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Health Check Day';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: vehicleInsuranceImgFrontController,
                decoration: const InputDecoration(
                    labelText: 'Vehicle Insurance Image Front URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the front insurance image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: vehicleInsuranceImgBackController,
                decoration: const InputDecoration(
                    labelText: 'Vehicle Insurance Image Back URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the URL for the back insurance image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tinController,
                decoration: const InputDecoration(labelText: 'TIN'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the TIN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: const Text('Submit Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    final registrationService = RegistrationService();

    try {
      final response = await registrationService.createRegistrationForm(
        driverId: int.parse(driverIdController.text),
        licensePlate: licensePlateController.text,
        vehicleType: vehicleTypeController.text,
        driversLicenseNumber: driversLicenseNumberController.text,
        driversLicenseImgFront: driversLicenseImgFrontController.text,
        driversLicenseImgBack: driversLicenseImgBackController.text,
        lltpImg: lltpImgController.text,
        vehicleRegistrationImg: vehicleRegistrationImgController.text,
        healthCheckDay: healthCheckDayController.text,
        vehicleInsuranceImgFront: vehicleInsuranceImgFrontController.text,
        vehicleInsuranceImgBack: vehicleInsuranceImgBackController.text,
        tin: tinController.text,
        authToken: authToken,
      );

      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Registration Successful: ${response['driverId']}')),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
