import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/message_screen.dart';

class DriverListScreen extends StatefulWidget {
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
      // Simulated API response
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      drivers = [
        {
          "registrationId": 1,
          "driver": {
            "driverId": 1,
            "username": "Tran Viet Phuc",
            "phone": "0987-656-5432",
            "email": "vietphuc@gmail.com",
            "averageRating": 4.5,
            "revenue": 5000,
            "role": "driver",
          }
        },
        {
          "registrationId": 2,
          "driver": {
            "driverId": 2,
            "username": "Quoc Huu",
            "phone": "0923-654-3210",
            "email": "quochuu@gmail.com",
            "averageRating": 4.8,
            "revenue": 6000,
            "role": "driver",
          }
        },
        // Add more drivers as needed
      ];
    } catch (e) {
      errorMessage = e.toString();
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
          title: Text('Danh Sách Các Tài Xế'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Danh Sách Các Tài Xế'),
        ),
        body: Center(child: Text('Error: $errorMessage')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Các Tài Xế'),
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          final driver = drivers[index]['driver'];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'), // Replace with your image URL
              ),
              title: Text(driver['username']),
              subtitle: Text(driver['phone']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageScreen(driver: driver),
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
