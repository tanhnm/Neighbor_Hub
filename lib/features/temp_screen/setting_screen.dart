import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/avatar_card.dart';
import 'package:flutter_application_1/domains/setting.dart';
import 'package:flutter_application_1/domains/user_model.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';

import '../../view/setting_tile.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  User? user;
  Box? userBox;
  Future<User>? userIdFuture;

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
