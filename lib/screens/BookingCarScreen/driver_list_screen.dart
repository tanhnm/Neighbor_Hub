import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/message_screen.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key, required this.booking});
  final Map<String, dynamic> booking;

  @override
  _DriverListScreenState createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  List<Map<String, dynamic>> drivers = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    try {
      var box = await Hive.openBox('locationBox');
      String userLocation = box.get('currentLocation');
      List<String> userLocationArray = userLocation.split(',');

      print('user location: ${userLocationArray[0]}:${userLocationArray[1]}');
      print('booking id: ${widget.booking['bookingId']}');

      // Fetch driver data from the API
      List<Map<String, dynamic>> fetchedDrivers =
          await BookingController(context: context)
              .getDriverNearUser(userLocation, widget.booking);

      // Update the drivers list with the fetched data
      setState(() {
        drivers = fetchedDrivers;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Danh Sách Các Tài Xế'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Danh Sách Các Tài Xế'),
        ),
        body: Center(child: Text('Error: $errorMessage')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Các Tài Xế'),
      ),
      body: drivers.isEmpty
          ? const Center(child: Text('No drivers found'))
          : ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'), // Replace with actual driver image URL if available
                    ),
                    title: Text(driver['username']),
                    subtitle: Text(driver['phone']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(
                              driver: driver, booking: widget.booking),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
