import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../common/routes.dart';
import '../../controller/booking_service.dart';

class ProfileMeScreen extends StatefulHookConsumerWidget {
  const ProfileMeScreen({super.key});

  @override
  _ProfileMeScreenState createState() => _ProfileMeScreenState();
}

class _ProfileMeScreenState extends ConsumerState<ProfileMeScreen> {
  Box<UserModel>? userBox;
  UserModel? user;
  Future<UserModel>? userIdFuture;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox(); // Initialize Hive box when the widget is created
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = Hive.box<UserModel>('users');
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

  Future<UserModel> _loadUser() async {
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
        title: const Text('Tài khoản'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Xóa tài khoản'),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Bạn có muốn xóa tài khoản không?'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Hủy'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              print('cac');
                              var box = Hive.box('appBox');
                              var locationBox = Hive.box('locationBox');
                              var userBox = Hive.box<UserModel>('users'); // Otherwise, open the box
                              var authBox = Hive.box('authBox');
                              await authBox.clear(); // Clears all data in the authBox
                              await userBox.clear();
                              await locationBox.clear();
                              await box.clear();
                              if(context.mounted){
                                context.pushReplacementNamed(Routes.login);
                              }
                              final bookingService =
                              ref.read(bookingServiceProvider);
                              await bookingService.deleteUser();

                              // Proceed with vehicle confirmation logic
                            },
                            child: const Text('Xác Nhận'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(FontAwesomeIcons.trash)),
        ],
      ),
      body: FutureBuilder<UserModel>(
        future: userIdFuture, // Using the Future from _initializeHiveBox
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('UserModel not found.'));
          }

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UserModel Image Section
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                // UserModel Info Section
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
                // UserModel Role Section
                Text(
                  'Role: ${user.role}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // UserModel Status Section
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
