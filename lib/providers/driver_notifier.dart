

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
final driverAmountProvider = StateProvider<int>((ref) => 0);

final priceProvider = StateProvider<int>((ref) => 0);

