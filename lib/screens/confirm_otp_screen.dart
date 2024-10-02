import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/register_screen.dart';

class ConfirmOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const ConfirmOtpScreen({super.key, required this.phoneNumber});

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isOtpInputted = false; // Track phone validation

  void _checkOtpInput() {
    setState(() {
      isOtpInputted = otpController1.text.isNotEmpty &&
          otpController2.text.isNotEmpty &&
          otpController3.text.isNotEmpty &&
          otpController4.text.isNotEmpty;
    });
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Xác nhận số điện thoại của bạn',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    'Nhập mã xác thực nhận vào tin nhắn được gửi đến ${widget.phoneNumber.length == 10 ? '${widget.phoneNumber.substring(0, 4)}******' : widget.phoneNumber} (Việt Nam)',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextField(
                        controller: otpController1,
                        onChanged: (value) => {
                          if (value.length == 1)
                            {
                              FocusScope.of(context).nextFocus(),
                              _checkOtpInput()
                            }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextField(
                        controller: otpController2,
                        onChanged: (value) => {
                          if (value.length == 1)
                            {
                              FocusScope.of(context).nextFocus(),
                              _checkOtpInput()
                            }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextField(
                        controller: otpController3,
                        onChanged: (value) => {
                          if (value.length == 1)
                            {
                              FocusScope.of(context).nextFocus(),
                              _checkOtpInput()
                            }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextField(
                        controller: otpController4,
                        onChanged: (value) => {
                          if (value.length == 1)
                            {
                              FocusScope.of(context).nextFocus(),
                              _checkOtpInput()
                            }
                        },
                        style: Theme.of(context).textTheme.headlineLarge,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor:
                          isOtpInputted ? const Color(0xFFFDC6D6) : null,
                    ),
                    onPressed: isOtpInputted
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // Process the phone number
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                          phone: widget.phoneNumber)));
                            }
                          }
                        : null, // Disable if not valid
                    child: Text('Tiếp tục',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isOtpInputted
                                ? Colors.black
                                : const Color.fromARGB(255, 155, 150, 150)))),
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFFFDC6D6)),
                    onPressed: () {
                      // Process the phone number send OTP
                    }, // Disable if not valid
                    child: const Text('Gửi lại mã',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
