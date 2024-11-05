import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/router.dart';
import 'package:flutter_application_1/common/routes.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../features/temp_screen/login_screen.dart'; // Ensure Hive is imported

//todo: remove and update
class Setting {
  final String title;
  final String route;
  final IconData icon;
  final Future<void> Function(BuildContext)?
      action; // Update action type to include BuildContext

  Setting({
    required this.title,
    required this.route,
    required this.icon,
    this.action,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: Routes.profile,
    icon: Icons.person,
  ),
  Setting(title: "Settings", route: "/settings", icon: Icons.settings),
  Setting(title: "Help", route: "/help", icon: Icons.help),
  Setting(title: "About", route: "/about", icon: Icons.info),
  Setting(title: "Share", route: "/share", icon: Icons.share),
  Setting(title: "Rate", route: "/rate", icon: Icons.star),
  Setting(title: "Privacy", route: "/privacy", icon: Icons.privacy_tip),
  Setting(title: "Terms", route: "/terms", icon: Icons.verified_user),
  Setting(
    title: "Log Out",
    route: "/logout",
    icon: Icons.logout,
    action: (BuildContext context) async {
      var box = Hive.box('appBox');
      var locationBox = Hive.box('locationBox');
      var userBox = Hive.box<UserModel>('users'); // Otherwise, open the box
      var authBox = Hive.box('authBox');
      await authBox.clear(); // Clears all data in the authBox
      await userBox.clear();
      await locationBox.clear();
      await box.clear();
      if(context.mounted){
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const LoginScreen()),
        // );
        context.pushReplacementNamed(Routes.login);
      }
    },
  ),
];

// Example of how to trigger the action with context
void onSettingTap(BuildContext context, Setting setting) {
  if (setting.action != null) {
    setting.action!(context); // Call the action with context
  } else {
    Navigator.pushNamed(context, setting.route);
  }
}
