import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';

import '../domains/freezed/driver_state_model.dart';


// Define the AsyncNotifier class that fetches the drivers
class DriverNotifier extends AsyncNotifier<DriverState> {

  DriverNotifier();

  @override
  Future<DriverState> build() async {
    return DriverState.initial(); // Initial state
  }

  // Method to fetch drivers
  Future<void> fetchDrivers(Map<String, dynamic> booking) async {
    state = const AsyncLoading(); // Set loading state
    try {
      var box = Hive.box('locationBox');
      String userLocation = box.get('currentLocation') ?? '';

      if (userLocation.isNotEmpty) {
        // Fetch drivers near the user
        List<Map<String, dynamic>>? fetchedDrivers =
        await BookingController()
            .getDriverNearUser(userLocation, booking);

        if (fetchedDrivers != null && fetchedDrivers.isNotEmpty) {
          // Update the state with fetched drivers
          state = AsyncData(DriverState(
            drivers: fetchedDrivers
                .map((driver) =>
            driver['driver'] as Map<String, dynamic>? ?? {})
                .toList(),
            registrationDrivers: fetchedDrivers
                .map((registration) => registration['registrationId'])
                .toList(),
          ));
        } else {
          // No drivers found
          state = AsyncData(DriverState.initial().copyWith(
            errorMessage: "No drivers found.",
          ));
        }
      } else {
        // Handle location not available
        _showLocationPrompt();
      }
    } catch (e) {
      // Handle any errors
      state = AsyncError(e.toString());
    }
  }

  // Mock location prompt function (you can implement this as needed)
  void _showLocationPrompt() {
    state = AsyncData(DriverState.initial().copyWith(
      errorMessage: "Location not available. Please enable location services.",
    ));
  }
}



final driverProvider = AsyncNotifierProvider<DriverNotifier, DriverState>(
  DriverNotifier.new,
);
