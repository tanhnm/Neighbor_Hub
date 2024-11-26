import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_application_1/services/remote_service/remote_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../providers/app_providers.dart';
import '../../providers/user_provider.dart';

class LoginPasswordScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const LoginPasswordScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends ConsumerState<LoginPasswordScreen> {
  final passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordValidated = false; // Track password validation
  final DriverService driverService = DriverService();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Set loading to true when submitting
      });
      try {
        // Process the password
        await RemoteAuth(context: context).signIn(
            phone: widget.phoneNumber,
            password: passwordTextEditingController.text);
        await driverService.getDriverByPhoneNumber(widget.phoneNumber);
        ref.invalidate(driverProvider);
        ref.invalidate(userProvider);
        String? token = await getTokenFromHive();
        if (token != null) {
          ref.read(tokenProvider.notifier).state = token;
        }
        await Future.delayed(Duration(seconds: 1));
      } finally {
        setState(() {
          isLoading = false; // Stop loading after the process completes
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng nhập với mật khẩu'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lên Xe Cùng Neighbor Hub',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(height: 36),
                TextFormField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu của bạn',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (password) {
                    setState(() {
                      // Check if the password meets criteria
                      isPasswordValidated =
                          password.length >= 5; // Example check
                    });
                  },
                  validator: (password) {
                    if (password != null && password.length >= 5) {
                      return null;
                    } else {
                      return 'Please enter a valid password';
                    }
                  },
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor:
                    isPasswordValidated ? const Color(0xFFFDC6D6) : null,
                  ),
                  onPressed: isPasswordValidated && !isLoading
                      ? _submit // Enable button if password is validated
                      : null, // Disable button if not validated
                  child: isLoading
                      ? LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 18)
                      : Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 20,
                      color: isPasswordValidated
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}