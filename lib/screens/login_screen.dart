import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/confirm_otp_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPhoneValidated = false; // Track phone validation

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Process the phone number
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmOtpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lên Xe Cùng Neighbor Hub',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(
                      'Đăng nhập / Đăng ký tài khoản',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Số Điện Thoại Của Bạn',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'VN',
                  controller: phoneTextEditingController,
                  onChanged: (phone) {
                    setState(() {
                      // Check if the phone number is valid
                      isPhoneValidated = phone.completeNumber.length >=
                          13; // Example length check
                    });
                  },
                  onSaved: (phone) {
                    // Save phone number if needed
                  },
                  validator: (phone) {
                    if (phone != null && phone.completeNumber.length >= 10) {
                      return null;
                    } else {
                      return 'Please enter a valid phone number';
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Allows only numeric input
                  ],
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor:
                        isPhoneValidated ? const Color(0xFFFDC6D6) : null,
                  ),
                  onPressed: isPhoneValidated
                      ? _submit // Enable button if phone is validated
                      : null, // Disable button if not validated
                  child: Text(
                    'Tiếp tục',
                    style: TextStyle(
                      fontSize: 20,
                      color: isPhoneValidated ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Hoặc",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Apple login button
                    GestureDetector(
                      onTap: () {
                        // Add your Apple login logic here
                      },
                      child: Image.asset(
                        'images/apple_logo.png', // Path to your Apple logo
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20), // Add spacing between buttons

                    // Facebook login button
                    GestureDetector(
                      onTap: () {
                        // Add your Facebook login logic here
                      },
                      child: Image.asset(
                        'images/facebook_logo.png', // Path to your Facebook logo
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Google login button
                    GestureDetector(
                      onTap: () {
                        // Add your Google login logic here
                      },
                      child: Image.asset(
                        'images/google_logo.png', // Path to your Google logo
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
