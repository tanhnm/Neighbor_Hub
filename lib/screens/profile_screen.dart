import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/avatar/avatar_card.dart';
import 'package:flutter_application_1/model/setting.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';

import '../common/widgets/settingTile/setting_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  Box? userBox;
  Future<User>? userIdFuture;
  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
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
        autoCloseDuration: const Duration(seconds: 3),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarCard(name: user?.username ?? ""),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                      settings.length,
                      (index) => Column(
                            children: [
                              SettingTile(
                                setting: settings[index],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider()
                            ],
                          )),
                )),
          ),
        ],
      ),
    );
  }
}
