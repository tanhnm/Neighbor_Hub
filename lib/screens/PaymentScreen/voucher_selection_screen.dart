import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/PaymentScreen/confirm_payment_screen.dart';

class VoucherSelectionScreen extends StatefulWidget {
  @override
  _VoucherSelectionScreenState createState() => _VoucherSelectionScreenState();
}

class _VoucherSelectionScreenState extends State<VoucherSelectionScreen> {
  String selectedVoucher = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher của bạn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('10% Off Voucher'),
              subtitle: Text('Valid until 31st Dec 2024'),
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
              leading: Icon(Icons.card_giftcard),
              title: Text('15% Off Voucher'),
              subtitle: Text('Valid until 31st Jan 2025'),
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
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xFFFDC6D6),
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
              child: Text('Continue to Payment',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
