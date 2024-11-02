import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/user_model.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';

class ProfileMeScreen extends StatefulWidget {
  const ProfileMeScreen({super.key});

  @override
  _ProfileMeScreenState createState() => _ProfileMeScreenState();
}

class _ProfileMeScreenState extends State<ProfileMeScreen> {
  Box<User>? userBox;
  User? user;
  Future<User>? userIdFuture;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox(); // Initialize Hive box when the widget is created
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = Hive.box<User>('users');
      setState(() {
        userIdFuture = _loadUser();
        userIdFuture!.then((value) => user = value);
      });
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
    }
  }

  Future<User> _loadUser() async {
    try {
      user = userBox?.get('user');
      if (user == null) {
        throw Exception('No user found in the Hive box.');
      }
      return user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<User>(
        future: userIdFuture, // Using the Future from _initializeHiveBox
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('User not found.'));
          }

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Image Section
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                // User Info Section
                Text(
                  user.username,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  user.phone,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                // User Role Section
                Text(
                  'Role: ${user.role}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // User Status Section
                Text(
                  'Status: ${user.status ? "Active" : "Inactive"}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
