import 'package:flutter/material.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final String selectedVoucher;

  const ConfirmPaymentScreen({super.key, required this.selectedVoucher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Payment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'You have selected the following voucher:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                selectedVoucher,
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 20),
              const Text(
                'Total Payment: \$100.00',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle payment confirmation logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment confirmed!')),
                  );
                },
                child: const Text('Confirm Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
