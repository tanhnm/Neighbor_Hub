import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/driver_service/registration_service.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

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
  final TextEditingController healthCheckDayController =
      TextEditingController();
  final TextEditingController tinController = TextEditingController();

  File? driversLicenseImgFront;
  File? driversLicenseImgBack;
  File? lltpImg;
  File? vehicleRegistrationImg;
  File? vehicleInsuranceImgFront;
  File? vehicleInsuranceImgBack;

  File? _selectedImage;
  String authToken = 'your_auth_token'; // Replace with your actual token
  bool isLoading = false; // To handle loading state

  // Image picker instance
  final ImagePicker _picker = ImagePicker();
  int? user;
  Box? userBox;
  Future<int>? userIdFuture;
  int? registrationFormId;
  int? registrationStatus;
  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = Hive.box('authBox');
      setState(() {
        userIdFuture = _loadUser();
        userIdFuture!.then((value) => user = value);
      });
      final forms = await RegistrationService().getAllRegistrationForms(user!);
      if (forms.isNotEmpty) {
        registrationFormId = forms[0]['registrationId'] as int?;
        registrationStatus = forms[0]['status'] as int?;
      }
    } catch (e) {
      print('Error opening Hive box: $e');
    }
  }

  Future<int> _loadUser() async {
    try {
      user = userBox?.get('driverId');
      if (user == null) {
        throw Exception('No user found in the Hive box.');
      }
      print(user);
      return user!;
    } catch (e) {
      print('Error loading user: $e');
      rethrow;
    }
  }

  Future _pickImageFromGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) return;
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _pickImage(String field) async {
    await _pickImageFromGallery();
    if (_selectedImage != null) {
      setState(() {
        switch (field) {
          case 'driversLicenseImgFront':
            driversLicenseImgFront = _selectedImage;
            break;
          case 'driversLicenseImgBack':
            driversLicenseImgBack = _selectedImage;
            break;
          case 'lltpImg':
            lltpImg = _selectedImage;
            break;
          case 'vehicleRegistrationImg':
            vehicleRegistrationImg = _selectedImage;
            break;
          case 'vehicleInsuranceImgFront':
            vehicleInsuranceImgFront = _selectedImage;
            break;
          case 'vehicleInsuranceImgBack':
            vehicleInsuranceImgBack = _selectedImage;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration',
            style: TextStyle(fontSize: 22, color: Colors.white)),
        backgroundColor: const Color(0xFFEF3167), // Themed color for your app
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: registrationStatus != 0
              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center horizontally
                    children: [
                      const Text(
                        'Bạn đã đăng ký xe rồi',
                        textAlign: TextAlign.center, // Center text
                        style: TextStyle(
                            fontSize: 18), // Optional: Adjust text size
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Action to perform when the button is pressed
                          print('Button pressed!');
                          setState(() {
                            registrationStatus = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFEF3167), // Background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                        ),
                        child: const Text('Bạn muốn đăng ký thêm xe?',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    _buildTextField(licensePlateController, 'Biển Số Xe',
                        Icons.directions_car),
                    // Two fields in one row
                    _buildTextField(
                        vehicleTypeController, 'Loại Xe', Icons.local_shipping),
                    const SizedBox(width: 8),

                    _buildTextField(driversLicenseNumberController,
                        'Mã Số Bằng Lái', Icons.credit_card),
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 40,
                      child: Text('Giấy Tờ Xe',
                          style: TextStyle(
                              fontSize: 22, color: Color(0xFFEF3167))),
                    ),
                    _buildImagePicker('Mặt Trước', vehicleRegistrationImg,
                        'vehicleRegistrationImg'),
                    // Image upload section
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 40,
                      child: Text('Bằng Lái Xe',
                          style: TextStyle(
                              fontSize: 22, color: Color(0xFFEF3167))),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildImagePicker('Mặt Trước', driversLicenseImgFront,
                              'driversLicenseImgFront'),
                          _buildImagePicker('Mặt Sau', driversLicenseImgBack,
                              'driversLicenseImgBack'),
                        ]),
                    const SizedBox(height: 16),
                    const SizedBox(
                      height: 40,
                      child: Text('Bảo Hiểm',
                          style: TextStyle(
                              fontSize: 22, color: Color(0xFFEF3167))),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildImagePicker(
                              'Mặt Trước',
                              vehicleInsuranceImgFront,
                              'vehicleInsuranceImgFront'),
                          _buildImagePicker('Mặt Sau', vehicleInsuranceImgBack,
                              'vehicleInsuranceImgBack'),
                        ]),

                    _buildTextField(
                        healthCheckDayController,
                        'Ngày Kiểm Tra Sức Khỏe (YYYY-MM-DD)',
                        Icons.calendar_today),
                    _buildTextField(
                        tinController, 'TIN', Icons.confirmation_number),

                    const SizedBox(height: 30),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                _submitForm();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: const Color(
                                  0xFFEF3167), // Themed color for your app
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Đăng ký thôi',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: const Color(0xFFEF3167)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFEF3167)),
          ),
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePicker(String labelText, File? imagePath, String field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(labelText, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _pickImage(field), // Open image picker on tap
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          imagePath,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(
                            'Thêm ảnh',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload images and get URLs
      String? driversLicenseFrontUrl;
      String? driversLicenseBackUrl;
      String? vehicleRegistrationUrl;
      String? vehicleInsuranceImgFrontUrl;
      String? vehicleInsuranceImgBackUrl;
      // if (driversLicenseImgFront != null) {
      //   driversLicenseFrontUrl = await uploadImageToFirebase(
      //       driversLicenseImgFront!, 'driversLicenseFront.jpg', userId ?? 0);
      // }
      // if (driversLicenseImgBack != null) {
      //   driversLicenseBackUrl = await uploadImageToFirebase(
      //       driversLicenseImgBack!, 'driversLicenseBack.jpg', userId ?? 0);
      // }
      // if (vehicleRegistrationImg != null) {
      //   vehicleRegistrationUrl = await uploadImageToFirebase(
      //       vehicleRegistrationImg!, 'vehicleRegistration.jpg', userId ?? 0);
      // }
      // if (vehicleInsuranceImgFront != null) {
      //   vehicleInsuranceImgFrontUrl = await uploadImageToFirebase(
      //       vehicleInsuranceImgFront!,
      //       'vehicleInsuranceFront.jpg',
      //       userId ?? 0);
      // }
      // if (vehicleInsuranceImgBack != null) {
      //   vehicleInsuranceImgBackUrl = await uploadImageToFirebase(
      //       vehicleInsuranceImgBack!, 'vehicleInsuranceBack.jpg', userId ?? 0);
      // }

      // Prepare the request body with the image URLs
      Map<String, dynamic> requestBody = {
        'driverId': user, // Ensure it's an int
        'licensePlate': '${licensePlateController.text}_$user',
        'vehicleType': '${vehicleTypeController.text}_$user',
        'driversLicenseNumber': '${driversLicenseNumberController.text}_$user',
        'driversLicenseImgFront': driversLicenseFrontUrl ??
            'driversLicenseImgFront+$user', // Use uploaded URL
        'driversLicenseImgBack': driversLicenseBackUrl ??
            'driversLicenseImgBack+$user', // Use uploaded URL
        'lltpImg':
            'lltpImg+$user', // Make sure to set this to the actual image URL if needed
        'vehicleRegistrationImg': vehicleRegistrationUrl ??
            'vehicleRegistrationImg+$user', // Use uploaded URL
        'healthCheckDay': healthCheckDayController.text,
        'vehicleInsuranceImgFront': vehicleInsuranceImgFront ??
            'vehicleInsuranceImgFront+$user', // Ensure these have valid URLs
        'vehicleInsuranceImgBack':
            vehicleInsuranceImgBack ?? 'vehicleInsuranceImgBack+$user',
        'tin': tinController.text,
      };

      print(requestBody);

      // Call API to submit the data
      await RegistrationService().createRegistrationForm(
        driverId: user!,
        licensePlate: licensePlateController.text,
        vehicleType: vehicleTypeController.text,
        driversLicenseNumber: driversLicenseNumberController.text,
        driversLicenseImgFront: driversLicenseFrontUrl ??
            'driversLicenseImgFront_$user', // Use uploaded URL
        driversLicenseImgBack: driversLicenseBackUrl ??
            'driversLicenseImgBack_$user', // Use uploaded URL
        lltpImg:
            'lltpImg_$user', // Make sure to set this to the actual image URL if needed
        vehicleRegistrationImg: vehicleRegistrationUrl ??
            'vehicleRegistrationImg_$user', // Use uploaded URL
        healthCheckDay: healthCheckDayController.text,
        vehicleInsuranceImgFront:
            'vehicleInsuranceImgFront_$user', // Ensure these have valid URLs
        vehicleInsuranceImgBack: 'vehicleInsuranceImgBack_$user',
        tin: tinController.text,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')));
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
