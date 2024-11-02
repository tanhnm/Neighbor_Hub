import 'package:flutter/material.dart';
// Adjust this import based on your project structure
import 'package:flutter_application_1/domains/user_model.dart';
import 'package:flutter_application_1/features/splash/introduction_screen.dart';
import 'package:hive/hive.dart';

import '../temp_screen/navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    var authBox = Hive.box('authBox');
    bool isLoggedIn = authBox.get('is_logged_in', defaultValue: false);
    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/Logo.png', width: 150, height: 150),
      ),
    );
  }
}
