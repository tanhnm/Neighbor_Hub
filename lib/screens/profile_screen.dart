import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/avatar/avatar_card.dart';
import 'package:flutter_application_1/model/setting.dart';

import '../common/widgets/settingTile/setting_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AvatarCard(),
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
