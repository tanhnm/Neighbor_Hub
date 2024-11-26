import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/remote_service/remote_auth.dart';

class RegisterScreen extends StatefulWidget {
  final String phone;

  const RegisterScreen({super.key, required this.phone});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPhoneValidated = false; // Track phone validation
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Process the form (Full Name, Email, Optional Invite Code)
      RemoteAuth(context: context).signUp(
        username: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: widget.phone,
      );
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const BottomNavBar()));
    }
  }

  InputDecoration _inputDecoration(String label, bool isRequired) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black, // Black color for label text
        fontSize: 16,
      ),

      suffixIcon: label == 'Mật Khẩu'
          ? IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _toggleVisibility, // Toggle visibility on press
            )
          : null,
      suffixText: isRequired ? '*' : null,
      suffixStyle: const TextStyle(
        color: Colors.red, // Red color for the asterisk
        fontSize: 16,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.zero, // No border radius
        borderSide: BorderSide(
          color: Colors.black, // Black border color
          width: 1.5, // Thickness of the border
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      contentPadding:
          const EdgeInsets.all(16.0), // Padding inside the input field
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hoàn Tất Đăng Ký',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                            'Nhập các thông tin bên dưới để hoàn tất',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ]),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        // Full Name Input
                        TextFormField(
                          controller: fullNameController,
                          decoration: _inputDecoration('Họ và Tên', true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập họ và tên';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email Input
                        TextFormField(
                          controller: emailController,
                          decoration: _inputDecoration('Email', true),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Vui lòng nhập email hợp lệ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: _inputDecoration('Mật Khẩu', true),
                          obscureText: _isObscured,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (value.length < 5) {
                              return 'Mật này phải bằng 6 ký tự trở lên';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Invite Code Input (Optional)
                        TextFormField(
                          controller: inviteCodeController,
                          decoration: _inputDecoration(
                              'Mã mời (không bắt buộc)', false),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: const Color(0xFFFDC6D6)),
                      onPressed: _submitForm,
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
