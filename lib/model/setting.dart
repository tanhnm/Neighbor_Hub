import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:hive/hive.dart'; // Ensure Hive is imported

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
  Setting(title: "Personal Data", route: "/profile", icon: Icons.person),
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
      var box = await Hive.openBox('appBox');
      await box.delete('authToken');
      print('Token cleared');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
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
