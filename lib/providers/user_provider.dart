
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../domains/user_model.dart';

final userProvider = FutureProvider<User?>((ref) async {
  try {
    final userBox = await Hive.openBox<User>('users');
    final user = userBox.get('user');
    if (user == null) {
      return User(userId: 1, username: '1', phone: '11', email: '11', role: '11', status: false);
      // throw Exception('No user found in the Hive box...');
    }
    return user;
  } catch (e) {
    throw Exception('Error loading user: $e');
  }
});


final userIdFutureProvider = FutureProvider<int?>((ref) async {
  final userBox = Hive.box('authBox');

  // Retrieve the user ID from Hive
  final userId = userBox.get('user_id') as int?;

  // Return the user ID (or null if not found)
  return userId;
});

final newUserProvider = Provider<User>((ref) {
  throw UnimplementedError('User has not been loaded yet.');
});

Future<User?> getUserFromHive() async {
  final userBox = await Hive.openBox<User>('users');
  final user = userBox.get('user');
  return user;
}