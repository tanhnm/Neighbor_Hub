import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/services/remote_service/remote_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPhoneValidated = false;
  bool isLoading = false; // Loading state

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Set loading to true when the API call starts
      });

      try {
        await RemoteAuth(context: context)
            .checkPhone(phone: phoneTextEditingController.text);
      } finally {
        setState(() {
          isLoading = false; // Stop loading after the API call completes
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
                      style: TextStyle(fontSize: 18),
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
                      isPhoneValidated = phone.completeNumber.length >= 13;
                    });
                  },
                  validator: (phone) {
                    if (phone != null && phone.completeNumber.length >= 10) {
                      return null;
                    } else {
                      return 'Please enter a valid phone number';
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: isPhoneValidated && !isLoading
                        ? const Color(0xFFFDC6D6)
                        : null,
                  ),
                  onPressed: isPhoneValidated && !isLoading ? _submit : null,
                  child: isLoading
                      ? LoadingAnimationWidget.waveDots(
                          color: Colors.white, size: 20)
                      : Text(
                          'Tiếp tục',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                isPhoneValidated ? Colors.black : Colors.grey,
                          ),
                        ),
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 25.0),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: Divider(
                //           color: Colors.grey,
                //           thickness: 1,
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Text(
                //           "Hoặc",
                //           style: TextStyle(
                //               fontSize: 20, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           color: Colors.grey,
                //           thickness: 1,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         // Apple login logic
                //       },
                //       child: Image.asset(
                //         'images/apple_logo.png',
                //         width: 40,
                //         height: 40,
                //       ),
                //     ),
                //     const SizedBox(width: 20),
                //     GestureDetector(
                //       onTap: () {
                //         // Facebook login logic
                //       },
                //       child: Image.asset(
                //         'images/facebook_logo.png',
                //         width: 40,
                //         height: 40,
                //       ),
                //     ),
                //     const SizedBox(width: 20),
                //     GestureDetector(
                //       onTap: () {
                //         // Google login logic
                //       },
                //       child: Image.asset(
                //         'images/google_logo.png',
                //         width: 40,
                //         height: 40,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
