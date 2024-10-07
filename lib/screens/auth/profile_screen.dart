import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/PaymentScreen/payment_method_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> driver;

  ProfileScreen({required this.driver});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isWaitingForDecision = true; // Initially, waiting for decision
  bool _isDealAccepted = false; // Initially, no decision made

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
    await Future.delayed(Duration(seconds: 3));

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
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
              ),
              radius: 50,
            ),
            SizedBox(height: 16),
            // Driver Info Section
            Text(
              widget.driver['username'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.driver['phone'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 4),
            Text(
              widget.driver['email'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
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
                    SizedBox(height: 4),
                    Text(
                      widget.driver['averageRating'].toString(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Lương',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${widget.driver['revenue']}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Driver Comments Section
            Text(
              'Bình Luận:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '⭐️' * comment['rating'], // Rating stars
                                style: TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
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
            _isWaitingForDecision
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Đang đợi tài xế chấp nhận deal',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      LoadingAnimationWidget.waveDots(
                          color: Colors.black, size: 20.0),
                    ],
                  )
                : _isDealAccepted
                    ? const Text(
                        'Tài xế đã chấp nhận deal!',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    : const Text(
                        'The driver has rejected the deal.',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
            SizedBox(height: 10),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: _isDealAccepted
                    ? () {
                        // Handle action for accepted deal
                      }
                    : null, // Disable button if deal is not accepted
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentMethodsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor:
                          _isDealAccepted ? Color(0xFFFDC6D6) : Colors.grey),
                  child: Text('Chốt Deal Với Tài Xế Này',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
                // Disable button color if not accepted
              ),
            ),
          ],
        ),
      ),
    );
  }
}
