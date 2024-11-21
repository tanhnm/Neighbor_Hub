import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../common/routes.dart';
import '../../controller/booking_service.dart';
import '../../services/driver_service/driver_service_new.dart';

class ProfileMeScreen extends StatefulHookConsumerWidget {
  const ProfileMeScreen({super.key});

  @override
  _ProfileMeScreenState createState() => _ProfileMeScreenState();
}

class _ProfileMeScreenState extends ConsumerState<ProfileMeScreen> {
  Box<UserModel>? userBox;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox(); // Initialize Hive box when the widget is created
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = await Hive.openBox<UserModel>('users');
      setState(() {});
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error: $e'),
      );
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
                ref.refresh(updateLocationDriverProvider);
              },
              icon: const Icon(FontAwesomeIcons.arrowsRotate)),
        ],
      ),
      body: userBox == null
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
        valueListenable: userBox!.listenable(),
        builder: (context, Box<UserModel> box, _) {
          final user = box.get('user');
          if (user == null) {
            return const Center(child: Text('UserModel not found.'));
          }

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
                TextButton(
                  onPressed: () async {
                    if (user.status) {
                      final driverService = ref.read(driverServiceProvider);
                      await driverService.unActivateDriver().then((value) {
                        if(value){
                          userBox!.put('user', user.copyWith(status: false));
                        }
                      });
                      // userBox!.put('user', user.copyWith(status: false));
                    } else {
                      ref.refresh(updateLocationDriverProvider);
                      userBox!.put('user', user.copyWith(status: true));
                    }
                  },
                  child: Text('Button'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}