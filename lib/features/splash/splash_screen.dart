import 'package:flutter/material.dart';
// Adjust this import based on your project structure
import 'package:flutter_application_1/domains/user_model.dart';
import 'package:flutter_application_1/features/splash/introduction_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../temp_screen/navbar_screen.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/Logo.png', width: 150, height: 150),
      ),
    );
  }
}