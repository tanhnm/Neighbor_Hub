
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../domains/freezed/user_model.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  try {
    final userBox = await Hive.openBox<UserModel>('users');
    final user = userBox.get('user');
    if (user == null) {
      throw Exception('No user found in the Hive box...');
    }
    return user;
  } catch (e) {
    throw Exception('Error loading user: $e');
  }
});


final userModelProvider = Provider<AsyncValue<UserModel?>>((ref) {
  return ref.watch(userProvider);
});



Future<bool> isUserLoggedIn() async {
  final userBox = await Hive.openBox<UserModel>('users');
  final user = userBox.get('user');
  return user != null;  // Return true if user is found, otherwise false
}

final driverProvider = FutureProvider<int?>((ref) async {
  final authBox = await Hive.openBox('authBox');
  final driverId = authBox.get('driverId', defaultValue: null);
  print(driverId);
  return driverId;
});

