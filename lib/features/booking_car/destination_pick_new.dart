import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/booking_car/map_screen_new.dart';
import 'package:flutter_application_1/features/driver/map_driver_screen_new.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../providers/current_position_provider.dart';
import '../../providers/user_provider.dart';
import '../driver/map_driver_screen.dart';
import 'map_screen.dart';

class DestinationPickNew extends HookConsumerWidget {
  const DestinationPickNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the location provider
    final locationAsyncValue = ref.watch(currentLocationProvider);
    final placesAsyncValue = ref.watch(nearbyPlacesProvider);

    // Watch other providers
    final isDriver = ref.watch(isDriverProvider);
    final user = ref.watch(userProvider);
    final registrationFormId = ref.watch(registrationFormIdProvider);
    final registrationStatus = ref.watch(registrationStatusProvider);

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
                      onTap: () {
                        locationAsyncValue.when(
                          data: (currentPosition) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isDriver
                                    ? MapDriverScreenNew(
                                        driverId: user.value!.userId,
                                        registrationID: registrationFormId!,
                                        lat: currentPosition.latitude,
                                        lon: currentPosition.longitude,
                                        registrationStatus: registrationStatus!,
                                      )
                                    : MapScreenNew(
                                        initialLatitude:
                                            currentPosition.latitude,
                                        initialLongitude:
                                            currentPosition.longitude,
                                      ),
                              ),
                            );
                          },
                          loading: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Fetching location...")),
                            );
                          },
                          error: (error, _) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $error")),
                            );
                          },
                        );
                      },
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
                    ),
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
                    onPressed: () {
                      locationAsyncValue.when(
                        data: (currentPosition) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => isDriver
                                  ? MapDriverScreen(
                                      driverId: user.value!.userId,
                                      registrationID: registrationFormId!,
                                      lat: currentPosition.latitude,
                                      lon: currentPosition.longitude,
                                      registrationStatus: registrationStatus!,
                                    )
                                  : MapScreen(
                                      initialLatitude: currentPosition.latitude,
                                      initialLongitude:
                                          currentPosition.longitude,
                                    ),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreenNew(
                                initialLatitude: currentPosition.latitude,
                               initialLongitude:  currentPosition.longitude,
                              ),
                            ),
                          );
                        },
                        loading: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Fetching location...")),
                          );
                        },
                        error: (error, _) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $error")),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: locationAsyncValue.when(
                      data: (_) => const Row(
                        children: [
                          Icon(FontAwesomeIcons.locationDot, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Chọn một điểm đến",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ],
                      ),
                      loading: () => LoadingAnimationWidget.waveDots(
                          color: Colors.black, size: 30),
                      error: (error, _) => Text(
                        "Error: $error",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Suggested destinations list
                Expanded(
                  child: placesAsyncValue.when(
                    data: (places) => ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        final placeName = place ?? 'Unknown';
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.red,
                            ),
                            title: Text(placeName),
                            trailing: const Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(
                      child: Text("Error: $error"),
                    ),
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
