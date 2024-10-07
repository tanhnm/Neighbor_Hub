import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/remote_service/remote_auth.dart';

class LoginPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  LoginPasswordScreen({super.key, required this.phoneNumber});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordValidated = false; // Track password validation

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      print("phone: ${widget.phoneNumber}");
      print("Password: ${passwordTextEditingController.text}");
      // Process the password
      RemoteAuth(context: context).signIn(
          phone: widget.phoneNumber,
          password: passwordTextEditingController.text);
      // Add your logic for password authentication here
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
                Text(
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
                  onPressed: isPasswordValidated
                      ? _submit // Enable button if password is validated
                      : null, // Disable button if not validated
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 20,
                      color: isPasswordValidated ? Colors.black : Colors.grey,
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
