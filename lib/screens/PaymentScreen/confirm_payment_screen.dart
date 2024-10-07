import 'package:flutter/material.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final String selectedVoucher;

  ConfirmPaymentScreen({required this.selectedVoucher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Payment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'You have selected the following voucher:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                selectedVoucher,
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                'Total Payment: \$100.00',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle payment confirmation logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment confirmed!')),
                  );
                },
                child: Text('Confirm Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
