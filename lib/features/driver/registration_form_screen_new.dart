import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/current_position_provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/driver_service/registration_service.dart';
final _formKey = GlobalKey<FormState>();
class RegistrationFormScreenNew extends HookConsumerWidget {
  const RegistrationFormScreenNew({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final driverIdController = useTextEditingController();
    final licensePlateController = useTextEditingController();
    final vehicleTypeController = useTextEditingController();
    final driversLicenseNumberController = useTextEditingController();
    final healthCheckDayController = useTextEditingController();
    final tinController = useTextEditingController();
    final  isLoading = useState(false);
    final user = ref.read(userProvider);

    final driversLicenseImgFront = useState<File?>(null);
    final driversLicenseImgBack = useState<File?>(null);
    final lltpImg = useState<File?>(null);
    final vehicleRegistrationImg = useState<File?>(null);
    final vehicleInsuranceImgFront = useState<File?>(null);
    final vehicleInsuranceImgBack = useState<File?>(null);
    final _selectedImage = useState<File?>(null);


    final registrationStatus = useState(ref.read(registrationStatusProvider));

    Future<void> _submitForm() async {

      isLoading.value = true;


      try {
        // Upload images and get URLs
        String? driversLicenseFrontUrl;
        String? driversLicenseBackUrl;
        String? vehicleRegistrationUrl;
        String? vehicleInsuranceImgFrontUrl;
        String? vehicleInsuranceImgBackUrl;


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

        // Call API to submit the data
        await RegistrationService().createRegistrationForm(
          driverId: user.value!.userId,
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

          isLoading.value = false;

      }
    }
    Future _pickImageFromGallery() async {
      try {
        final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if (returnedImage == null) return;

        _selectedImage.value = File(returnedImage.path);

      } catch (e) {
        rethrow;
      }
    }
    Future<void> _pickImage(String field) async {
      await _pickImageFromGallery();
      if (_selectedImage.value != null) {

          switch (field) {
            case 'driversLicenseImgFront':
              driversLicenseImgFront.value = _selectedImage.value;
              break;
            case 'driversLicenseImgBack':
              driversLicenseImgBack.value = _selectedImage.value;
              break;
            case 'lltpImg':
              lltpImg.value = _selectedImage.value;
              break;
            case 'vehicleRegistrationImg':
              vehicleRegistrationImg.value = _selectedImage.value;
              break;
            case 'vehicleInsuranceImgFront':
              vehicleInsuranceImgFront.value = _selectedImage.value;
              break;
            case 'vehicleInsuranceImgBack':
              vehicleInsuranceImgBack.value = _selectedImage.value;
              break;
          }

      }
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
          child: registrationStatus.value != 0
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
                      //:note: ????????????
                      registrationStatus.value = 0;

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
              _buildImagePicker('Mặt Trước', vehicleRegistrationImg.value,
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
                    _buildImagePicker('Mặt Trước', driversLicenseImgFront.value,
                        'driversLicenseImgFront'),
                    _buildImagePicker('Mặt Sau', driversLicenseImgBack.value,
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
                        vehicleInsuranceImgFront.value,
                        'vehicleInsuranceImgFront'),
                    _buildImagePicker('Mặt Sau', vehicleInsuranceImgBack.value,
                        'vehicleInsuranceImgBack'),
                  ]),

              _buildTextField(
                  healthCheckDayController,
                  'Ngày Kiểm Tra Sức Khỏe (YYYY-MM-DD)',
                  Icons.calendar_today),
              _buildTextField(
                  tinController, 'TIN', Icons.confirmation_number),

              const SizedBox(height: 30),
              isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                      isLoading.value = true;

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







}
