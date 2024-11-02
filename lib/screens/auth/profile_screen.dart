import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/PaymentScreen/qrcode_payment_screen.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> driver;
  final Map<String, dynamic> booking;
  final int registrationFormId;

  const ProfileScreen(
      {super.key,
      required this.driver,
      required this.booking,
      required this.registrationFormId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isWaitingForDecision = true; // Initially, waiting for decision
  bool _isDealAccepted = false; // Initially, no decision made
  Map<String, dynamic> driverAmount = {'amount': 0.0};
  String price = '0.0';

  final List<Map<String, dynamic>> comments = [
    {
      "username": "Viet Phuc",
      "rating": 5,
      "comment": "Great driver! Highly recommend."
    },
    {
      "username": "Ha Giang",
      "rating": 4,
      "comment": "Very polite and punctual."
    },
    {
      "username": "Minh Phu",
      "rating": 3,
      "comment": "Average experience, could improve."
    },
  ];

  Future<void> _simulateDriverDecision() async {
    // Simulate driver decision after some delay (e.g., 3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isWaitingForDecision = false;
      // You can set this to true or false based on the driver's decision
      _isDealAccepted = true; // Set to true if driver accepts, false otherwise
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateDriverDecision(); // Start simulating the driver's decision
    _loadInfoBooking();
  }

  Future<void> _loadInfoBooking() async {
    final Map<String, dynamic> amount =
        await BookingController(context: context).getDriverAmount(
      widget.driver['driverId'],
      widget.booking['bookingId'],
    );
    print("loading info price");
    print("widget.driver['driverId']: ${widget.driver['driverId']}");
    print("widget.booking['bookingId']: ${widget.booking['bookingId']}");
    setState(() {
      if (amount.isEmpty) return;
      driverAmount = amount;
      if (driverAmount['amount'] > 0.0) {
        price = driverAmount['amount'].toString();
      }
    });
    print(driverAmount['amount'] > 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin ${widget.driver['username']}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Image Section
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
              ),
              radius: 50,
            ),
            const SizedBox(height: 16),
            // Driver Info Section
            Text(
              widget.driver['username'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.driver['phone'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              widget.driver['email'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            // Ratings and Revenue Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.driver['averageRating'].toString(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Lương',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${widget.driver['revenue']}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Driver Comments Section
            const Text(
              'Bình Luận:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comment['username'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '⭐️' * comment['rating'], // Rating stars
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(comment['comment']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Add Deal Price Driver waiting for decision
            driverAmount['amount'] > 0.0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Người chở ra giá \$$price',
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đang đợi tài xế chấp nhận deal',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      LoadingAnimationWidget.waveDots(
                          color: Colors.black, size: 20.0),
                    ],
                  ),
            const SizedBox(height: 10),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: driverAmount['amount'] > 0.0
                        ? const Color(0xFFFDC6D6)
                        : Colors.grey),
                onPressed: driverAmount['amount'] > 0.0
                    ? () async {
                        // Handle action for accepted deal
                        print('Accepted deal!');
                        Future<Map<String, dynamic>> addDriver() async {
                          return BookingController(context: context).addDriver(
                              registrationId: widget.registrationFormId,
                              bookingId: widget.booking['bookingId']);
                        }

                        Map<String, dynamic> data = await addDriver();
                        String imgUrlPayment = '';
                        // Handle action for accepted deal
                        Future<String> simulateDriverDecision() async {
                          return BookingController(context: context)
                              .createQrCodePayment(widget.booking['bookingId']);
                        }

                        imgUrlPayment = await simulateDriverDecision();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRCodeScanPage(
                              imgUrl: imgUrlPayment,
                            ),
                          ), // SelectRatingScreen
                        );
                      }
                    : null, // Disable button if deal is not accepted
                child: const Text('Chốt Deal Với Tài Xế Này',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                // Disable button color if not accepted
              ),
            ),
          ],
        ),
      ),
    );
  }
}
