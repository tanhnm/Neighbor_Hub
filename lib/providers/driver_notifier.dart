

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/fare_service/booking_controller.dart';

class DriverDecisionNotifier extends StateNotifier<bool> {
  DriverDecisionNotifier() : super(true); // Initially waiting for decision

  Future<void> simulateDriverDecision() async {
    await Future.delayed(const Duration(seconds: 3));
    state = false; // Decision made (accepted or rejected)
  }
}

// Provider for driver's decision state
final driverDecisionProvider = StateNotifierProvider<DriverDecisionNotifier, bool>((ref) {
  return DriverDecisionNotifier();
});

// Provider for deal acceptance status
final dealAcceptedProvider = StateProvider<bool>((ref) => false);

// Provider for driver amount
final driverAmountProvider = StateProvider<Map<String, dynamic>>((ref) => {'amount': 0.0});

final priceProvider = StateProvider<String>((ref) => '0.0');

// Function to load booking info using a FutureProvider
final bookingInfoProvider = FutureProvider.family<Map<String, dynamic>, Map<String, dynamic>>((ref, bookingData) async {
  final driverId = bookingData['driverId'];
  final bookingId = bookingData['bookingId'];
  final amount = await BookingController().getDriverAmount(driverId, bookingId);
  return amount;
});