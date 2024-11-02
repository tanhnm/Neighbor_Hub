import 'package:flutter/material.dart';

class QRCodeScanPage extends StatefulWidget {
  final String imgUrl;
  const QRCodeScanPage({super.key, required this.imgUrl});
  @override
  _QRCodeScanPageState createState() => _QRCodeScanPageState();
}

class _QRCodeScanPageState extends State<QRCodeScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? qrImageUrl; // Holds the URL for the QR code image

  @override
  void initState() {
    super.initState();
    qrImageUrl = widget.imgUrl;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            qrImageUrl != null
                ? Image.network(
                    qrImageUrl!) // Display QR code image from backend
                : const CircularProgressIndicator(), // Loading indicator while fetching the image
            const SizedBox(height: 20),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Scan QR Code Để Thanh Toán",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Hãy Chụp Màn Hình Lại Rồi Scan Nha Bạn Nhé",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Ngân hàng nào cũng quét đc bạn nhé",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Chủ Tài Khoản: TRAN HUONG GIANG"),
            const SizedBox(
              height: 16,
            ),
            const Text("Số Tài Khoản: 07966744822"),
          ],
        ),
      ),
    );
  }
}
