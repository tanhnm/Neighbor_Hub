import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/voucher.dart';
import 'package:flutter_application_1/services/voucher_service/voucher_service.dart';
import 'package:hive/hive.dart';

// Voucher model class
// VoucherCard widget
class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});

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
                const SizedBox(height: 8),
                Text(voucher.description,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(voucher.description),
                const SizedBox(height: 8),
                Text('Discount: \$${voucher.discount}',
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// VoucherListPage widget
class VoucherListPage extends StatefulWidget {
  const VoucherListPage({super.key});

  @override
  State<VoucherListPage> createState() => _VoucherListPageState();
}

class _VoucherListPageState extends State<VoucherListPage> {
  List<dynamic> voucherss = [];
  late Box userBox;

  @override
  void initState() {
    super.initState();
    VoucherService(context: context).getVoucher(); // Call the API here
    userBox = Hive.box('authBox');
  }

  getVouchers() async {
    print(userBox.get('vouchers'));
  }

  final List<Voucher> vouchers = [
    Voucher(
      voucherId: 1,
      description: 'Get 10% off on your next ride!',
      code: 'Get 10% off on your next ride!',
      expiryDate: '2024-01-01',
      discount: 10.0,
      imageUrl: 'images/voucher1.png', // Example asset path
    ),
    Voucher(
      voucherId: 2,
      description: 'Enjoy a free ride up to \$20!',
      code: 'Enjoy a free ride up to \$20!',
      expiryDate: '2024-01-01',
      discount: 20.0,
      imageUrl: 'images/voucher2.png', // Example asset path
    ),
    // Add more vouchers here
  ];

  @override
  Widget build(BuildContext context) {
    getVouchers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vouchers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
