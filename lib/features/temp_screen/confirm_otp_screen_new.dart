import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/remote_service/remote_auth.dart';


class ConfirmOtpScreenNew extends HookConsumerWidget {
  const ConfirmOtpScreenNew({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final otpController1 = useTextEditingController();
    final otpController2 = useTextEditingController();
    final otpController3 = useTextEditingController();
    final otpController4 = useTextEditingController();

    final _formKey = GlobalKey<FormState>();
    final isOtpInputted = useState(false);
    final isLoading = useState(false);

    _checkOtpInput() {
      isOtpInputted.value = otpController1.text.isNotEmpty &&
          otpController2.text.isNotEmpty &&
          otpController3.text.isNotEmpty &&
          otpController4.text.isNotEmpty;
    }
    void _deleteOtpInput() {
      
        isOtpInputted.value = otpController4.text.isNotEmpty &&
            otpController3.text.isNotEmpty &&
            otpController2.text.isNotEmpty &&
            otpController1.text.isNotEmpty;
    }

    void _submit() async {
      if (_formKey.currentState!.validate()) {
        try {
          
            isLoading.value = true;
          
          await RemoteAuth(context: context).verifySMSOTP(
              phone: phoneNumber,
              code:
              '${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');
        } catch (e) {
          
          Fluttertoast.showToast(
            msg: 'Error: $e',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        } finally {
         
            isLoading.value = false;
          
        }
      }
    }

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
                    'Nhập mã xác thực nhận vào tin nhắn được gửi đến ${phoneNumber.length == 10 ? '${phoneNumber.substring(0, 4)}******' : phoneNumber} (Việt Nam)',
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
                          else
                            {
                              FocusScope.of(context).previousFocus(),
                              _deleteOtpInput()
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
                          else
                            {
                              FocusScope.of(context).previousFocus(),
                              _deleteOtpInput()
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
                          else
                            {
                              FocusScope.of(context).previousFocus(),
                              _deleteOtpInput()
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
                          else
                            {
                              FocusScope.of(context).previousFocus(),
                              _deleteOtpInput()
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
                      isOtpInputted.value ? const Color(0xFFFDC6D6) : null,
                    ),
                    onPressed: isOtpInputted.value
                        ? () {
                      if (_formKey.currentState!.validate()) {
                        _submit();
                      }
                    }
                        : null, // Disable if not valid
                    child: isLoading.value
                        ? LoadingAnimationWidget.waveDots(
                        color: Colors.black, size: 50)
                        : Text('Tiếp tục',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isOtpInputted.value
                                ? Colors.black
                                : const Color.fromARGB(
                                255, 155, 150, 150)))),
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
