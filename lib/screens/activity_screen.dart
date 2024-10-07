import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/driver_list_screen.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/screens/navbar_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Add padding to the list
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the driver list screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverListScreen(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "View Drivers Matches",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the booking details screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         BookingDetailsScreen(), // Replace with your actual booking details screen
              //   ),
              // );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "View My Bookings",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
