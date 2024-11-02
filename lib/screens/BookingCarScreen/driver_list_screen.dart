import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/message_screen.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:geolocator/geolocator.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({Key? key, required this.booking}) : super(key: key);
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    try {
      var box = Hive.box('locationBox');
      String userLocation = box.get('currentLocation') ?? '';

      if (userLocation.isNotEmpty) {
        List<Map<String, dynamic>>? fetchedDrivers =
            await BookingController(context: context)
                .getDriverNearUser(userLocation, widget.booking);

        if (fetchedDrivers != null && fetchedDrivers.isNotEmpty) {
          setState(() {
            drivers = fetchedDrivers
                .map(
                    (driver) => driver['driver'] as Map<String, dynamic>? ?? {})
                .toList();
            registrationDrivers = fetchedDrivers
                .map((registration) => registration['registrationId'])
                .toList();
            errorMessage = null;
          });
        } else {
          setState(() {
            errorMessage = "No drivers found.";
          });
        }
      } else {
        _showLocationPrompt();
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        errorMessage = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                Navigator.of(context).pop();
                _getCurrentLocationAndUpdate();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentLocationAndUpdate() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        String userLocation = '${position.latitude},${position.longitude}';

        var box = Hive.box('locationBox');
        await box.put('currentLocation', userLocation);

        fetchDrivers();
      } else {
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
        appBar: AppBar(title: const Text('Danh Sách Các Tài Xế')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Danh Sách Các Tài Xế')),
        body: Center(child: Text('Error: $errorMessage')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Danh Sách Các Tài Xế')),
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
                          'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'),
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
