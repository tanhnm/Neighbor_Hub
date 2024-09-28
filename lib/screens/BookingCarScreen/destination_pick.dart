import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator for location services
import 'package:flutter_application_1/screens/BookingCarScreen/map_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DestinationPick extends StatefulWidget {
  const DestinationPick({super.key});

  @override
  State<DestinationPick> createState() => _DestinationPickState();
}

class _DestinationPickState extends State<DestinationPick> {
  // List of sample destinations (for demonstration purposes)
  final List<Map<String, String>> suggestedDestinations = [
    {"name": "Central Park", "location": "New York, USA"},
    {"name": "Eiffel Tower", "location": "Paris, France"},
    {"name": "Colosseum", "location": "Rome, Italy"},
    {"name": "Great Wall", "location": "China"},
    {"name": "Sydney Opera House", "location": "Sydney, Australia"},
  ];

  // Function to request location permission and get current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If not enabled, show error
      return Future.error('Location services are disabled.');
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // Handle the case where permissions are permanently denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // If permission granted, return the current position
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container covering half of the button height
          Container(
            height: MediaQuery.of(context).size.height * 0.285 + 10,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFEF3167), // Background color for the top half
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 60, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Navigates back
                      },
                      child: const Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: null,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(FontAwesomeIcons.map, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Map",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Travel with Neighbor",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Ride Together",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "Connect Forever",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Destination input button
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9, // 90% width
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Call the function to request permission and get current location
                        Position position = await _determinePosition();
                        print(
                            'Current position: ${position.latitude}, ${position.longitude}');

                        // Pass the position to the MapScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              initialLatitude: position.latitude,
                              initialLongitude: position.longitude,
                            ),
                          ),
                        );
                      } catch (e) {
                        // Handle any errors that occur during permission request
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(FontAwesomeIcons.locationDot, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "Pick Location",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                // Suggested destinations list
                Expanded(
                  child: ListView.builder(
                    itemCount: suggestedDestinations.length,
                    itemBuilder: (context, index) {
                      final destination = suggestedDestinations[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.red,
                          ),
                          title: Text(destination['name']!),
                          subtitle: Text(destination['location']!),
                          trailing: const Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            // Action when a destination is selected
                            print(
                                'Selected destination: ${destination['name']}');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
