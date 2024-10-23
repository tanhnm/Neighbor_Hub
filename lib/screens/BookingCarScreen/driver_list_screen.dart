import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/message_screen.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator package

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key, required this.booking});
  final Map<String, dynamic> booking;

  @override
  _DriverListScreenState createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  List<Map<String, dynamic>> drivers = [];
  List<dynamic> registrationDrivers = [];
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
      String? userLocation = box.get('currentLocation') as String?;

      if (userLocation != null && userLocation.isNotEmpty) {
        List<String> userLocationArray = userLocation.split(',');

        if (userLocationArray.length == 2) {
          print(
              'user location: ${userLocationArray[0]}:${userLocationArray[1]}');
          print('booking id: ${widget.booking['bookingId']}');

          // Fetch driver data from the API
          List<Map<String, dynamic>>? fetchedDrivers =
              await BookingController(context: context)
                  .getDriverNearUser(userLocation, widget.booking);
          print(
              'fetchedDrivers: ${fetchedDrivers?.map((driver) => driver['driver'])}');
          if (fetchedDrivers != null && fetchedDrivers.isNotEmpty) {
            setState(() {
              drivers = fetchedDrivers
                  .map((driver) => driver['driver'] as Map<String, dynamic>?)
                  .where((driver) => driver != null)
                  .cast<Map<String, dynamic>>()
                  .toList();

              registrationDrivers = fetchedDrivers
                  .map((registration) => registration['registrationId'])
                  .where((id) => id != null)
                  .toList();
            });
            print(
                "fetchedDrivers : ${fetchedDrivers.map((registration) => registration['registrationId']).toList()}");
          } else {
            setState(() {
              errorMessage = "No drivers found.";
            });
          }
        } else {
          setState(() {
            errorMessage = "Invalid user location.";
          });
        }
      } else {
        // Ask the user to turn on their location
        _showLocationPrompt();
      }
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

  // Function to show a dialog prompting the user to turn on location
  void _showLocationPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Needed'),
          content: const Text(
              'Please turn on your location services to find nearby drivers.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Use Future.microtask to avoid blocking the UI
                Future.microtask(() async {
                  await _getCurrentLocationAndUpdate();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to get current location and update the Hive box
  Future<void> _getCurrentLocationAndUpdate() async {
    try {
      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Get the current location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        String userLocation = '${position.latitude},${position.longitude}';

        // Update Hive box with the new location
        var box = await Hive.openBox('locationBox');
        await box.put('currentLocation', userLocation);

        // Call fetchDrivers to refresh the drivers list
        fetchDrivers();
      } else {
        // Handle denied permission case
        setState(() {
          errorMessage =
              "Location permission denied. Please enable it in settings.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error retrieving location: ${e.toString()}";
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
                final registrationId = registrationDrivers[index];
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
                            driver: driver,
                            booking: widget.booking,
                            registrationId: registrationId,
                          ),
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
