import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/PaymentScreen/voucher_selection_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phương Thức Thanh Toán'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PaymentMethods(),
      ),
    );
  }
}

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  String selectedMethod = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Thẻ tín dụng'),
            trailing: Radio<String>(
              value: 'Credit/Debit Card',
              groupValue: selectedMethod,
              onChanged: (String? value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('PayPal'),
            trailing: Radio<String>(
              value: 'PayPal',
              groupValue: selectedMethod,
              onChanged: (String? value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Google Pay'),
            trailing: Radio<String>(
              value: 'Google Pay',
              groupValue: selectedMethod,
              onChanged: (String? value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Tiền Mặt'),
            trailing: Radio<String>(
              value: 'Cash on Delivery',
              groupValue: selectedMethod,
              onChanged: (String? value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xFFFDC6D6)),
            onPressed: selectedMethod.isNotEmpty
                ? () {
                    // Handle the selected payment method
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoucherSelectionScreen()));
                  }
                : null,
            child: Text('Confirm Payment Method',
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
