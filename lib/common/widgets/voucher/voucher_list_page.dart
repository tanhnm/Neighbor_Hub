import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/voucher.dart';

// Voucher model class
// VoucherCard widget
class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              voucher.imageUrl, // Load the image
              height: 100, // Set height
              fit: BoxFit.cover, // Adjust the box fit as needed
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(voucher.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(voucher.description),
                SizedBox(height: 8),
                Text('Discount: \$${voucher.discount}',
                    style: TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// VoucherListPage widget
class VoucherListPage extends StatelessWidget {
  final List<Voucher> vouchers = [
    Voucher(
      title: '10% Off',
      description: 'Get 10% off on your next ride!',
      discount: 10.0,
      imageUrl: 'images/voucher1.png', // Example asset path
    ),
    Voucher(
      title: 'Free Ride',
      description: 'Enjoy a free ride up to \$20!',
      discount: 20.0,
      imageUrl: 'images/voucher2.png', // Example asset path
    ),
    // Add more vouchers here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vouchers'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return VoucherCard(voucher: vouchers[index]);
        },
      ),
    );
  }
}
