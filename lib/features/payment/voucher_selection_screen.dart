import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/payment/confirm_payment_screen.dart';

class VoucherSelectionScreen extends StatefulWidget {
  const VoucherSelectionScreen({super.key});

  @override
  _VoucherSelectionScreenState createState() => _VoucherSelectionScreenState();
}

class _VoucherSelectionScreenState extends State<VoucherSelectionScreen> {
  String selectedVoucher = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher của bạn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('10% Off Voucher'),
              subtitle: const Text('Valid until 31st Dec 2024'),
              trailing: Radio<String>(
                value: '10% Off Voucher',
                groupValue: selectedVoucher,
                onChanged: (String? value) {
                  setState(() {
                    selectedVoucher = value!;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('15% Off Voucher'),
              subtitle: const Text('Valid until 31st Jan 2025'),
              trailing: Radio<String>(
                value: '15% Off Voucher',
                groupValue: selectedVoucher,
                onChanged: (String? value) {
                  setState(() {
                    selectedVoucher = value!;
                  });
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFFDC6D6),
              ),
              onPressed: selectedVoucher.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmPaymentScreen(
                            selectedVoucher: selectedVoucher,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Continue to Payment',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
