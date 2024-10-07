import 'package:flutter/material.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart'; // Ensure you add the package in pubspec.yaml

class VNPayPaymentScreen extends StatefulWidget {
  @override
  _VNPayPaymentScreenState createState() => _VNPayPaymentScreenState();
}

class _VNPayPaymentScreenState extends State<VNPayPaymentScreen> {
  final String _tmnCode =
      'Your_TmnCode'; // Replace with your actual tmnCode from VNPAY
  final String _vnpayHashKey =
      'Your_VNPAY_HashKey'; // Replace with your actual hash key
  final String _returnUrl =
      'https://abc.com/return'; // Replace with your actual return URL
  final String _ipAddress =
      '192.168.10.10'; // Replace with the actual IP address

  // Function to handle payment
  void _handlePayment() async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
      version: '2.0.1',
      tmnCode: _tmnCode,
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Pay 30.000 VND',
      amount: 30000, // Amount in VND
      returnUrl: _returnUrl,
      ipAdress: _ipAddress,
      vnpayHashKey: _vnpayHashKey,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
      vnPayHashType: VNPayHashType.HMACSHA512,
    );

    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        _showResultDialog('Payment Success', params.toString());
      },
      onPaymentError: (params) {
        _showResultDialog('Payment Error', params.toString());
      },
      onWebPaymentComplete: () {
        print('Web payment completed');
      },
    );
  }

  // Function to show result dialog
  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VNPay Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Proceed to pay 30,000 VND using VNPay',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePayment,
              child: Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
