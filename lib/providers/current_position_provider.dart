


import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

import '../data/api/api.dart';
import '../services/driver_service/registration_service.dart';

final currentLocationProvider = FutureProvider<Position>((ref) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Bạn chưa mở vị trí trên điện thoại!.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Quyền truy cập vị trí của điện thoại chưa được cho phép!');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Quyền truy cập vị trí đã bị từ chối vui lòng mở lại nhé!.');
  }

  return await Geolocator.getCurrentPosition();
});

final nearbyPlacesProvider = FutureProvider<List<dynamic>>((ref) async {
  final location = await ref.watch(currentLocationProvider.future);
  return await getNearbyPlaces(location.latitude, location.longitude);
});

final hiveInitializationProvider = FutureProvider<void>((ref) async {
  final userBox = Hive.box('authBox');

  // Retrieve whether the user is a driver from Hive
  final isDriver = userBox.get('is_driver', defaultValue: false) ?? false;

  // Update the isDriverProvider state
  ref.read(isDriverProvider.notifier).state = isDriver;

  if (isDriver) {
    // Fetch the user using userProvider
    final user = await ref.read(userProvider.future);

    if (user != null) {
      // Fetch registration forms for the user using user.id
      final forms = await RegistrationService().getAllRegistrationForms(user.userId);

      if (forms.isNotEmpty) {
        // Update registrationFormIdProvider with the first form's ID
        ref.read(registrationFormIdProvider.notifier).state = forms[0]['registrationId'] as int?;

        // Update registrationFormStatusProvider with the first form's status
        ref.read(registrationStatusProvider.notifier).state = forms[0]['status'] as int?;
      }
    }
  }
});


final isDriverProvider = StateProvider<bool>((ref) => false);
final registrationFormIdProvider = StateProvider<int?>((ref) => null);
final registrationStatusProvider = StateProvider<int?>((ref) => null);
