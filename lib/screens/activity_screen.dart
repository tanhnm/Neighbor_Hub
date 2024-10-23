import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/driver_list_screen.dart';
import 'package:flutter_application_1/screens/auth/profile_screen.dart';
import 'package:flutter_application_1/screens/navbar_screen.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:flutter_application_1/utils/convertTime/convert_time.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<dynamic> bookings = [];
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _loadUser() async {
    var userBox = await Hive.openBox<User>('users');
    user = userBox.get('user');
  }

  // Function to fetch booking data
  Future<void> _fetchBookings() async {
    try {
      await _loadUser();
      final response = await BookingController(context: context)
          .getBookingsByUserId(user?.userId ?? 0);
      setState(() {
        bookings = response; // Decode the JSON response
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: bookings.isEmpty
          ? (isLoading
              ? Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 50))
              : const Center(
                  child: Text(
                      'No bookings found'))) // Show loading indicator while fetching data
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                var booking = bookings[index];

                // Extract relevant booking details
                var pickupLocation = booking['pickupLocation'];
                var dropoffLocation = booking['dropoffLocation'];
                var pickupTime =
                    convertToVietnameseTime(booking['pickupTime'].toString());
                var status = booking['status'];
                var amount = booking['amount'];
                var driver =
                    booking?['registration']?['driver']?['username'] ?? 'N/A';
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Điểm đón: $pickupLocation",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Điểm đi: $dropoffLocation",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pickupTime,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Tình Trạng: $status",
                          style: TextStyle(
                            fontSize: 16,
                            color: status == "completed"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Người chở: $driver",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Giá Thỏa Thuận: \$$amount",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: driver == 'N/A'
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverListScreen(
                                                booking: booking,
                                              )));
                                }
                              : () {
                                  // Handle view booking details logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                        driver: {
                                          "driverId": 1,
                                          "username": booking['registration']
                                              ['driver']['username'],
                                          "phone": booking['registration']
                                              ['driver']['phone'],
                                          "email": booking['registration']
                                              ['driver']['email'],
                                          "averageRating":
                                              booking['registration']['driver']
                                                      ['averageRating'] ??
                                                  0,
                                          "revenue": booking['registration']
                                                  ['driver']['revenue'] ??
                                              0,
                                        },
                                        registrationFormId:
                                            booking['registration']
                                                ['registrationId'],
                                        booking: booking,
                                      ),
                                    ),
                                  );
                                },
                          child: driver == 'N/A'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      const Text('Đang Tìm Tài Xế'),
                                      const SizedBox(width: 8),
                                      LoadingAnimationWidget.waveDots(
                                          color: Colors.black, size: 16),
                                    ])
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Deal Với Tài Xế Ngay')]),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// BookingDetailsScreen to show more detailed information about each booking
class BookingDetailsScreen extends StatelessWidget {
  final dynamic booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    var pickupLocation = booking['pickupLocation'];
    var dropoffLocation = booking['dropoffLocation'];
    var status = booking['status'];
    var amount = booking['amount'];
    var driver = booking['registration']['driver']['username'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pickup Location: $pickupLocation"),
            Text("Dropoff Location: $dropoffLocation"),
            Text("Status: $status"),
            Text("Driver: $driver"),
            Text("Amount: \$$amount"),
          ],
        ),
      ),
    );
  }
}
