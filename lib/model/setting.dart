import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({required this.title, required this.route, required this.icon});
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
  Setting(title: "Log Out", route: "/logout", icon: Icons.logout),
];
