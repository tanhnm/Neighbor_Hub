import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart'; // Adjust this import based on your project structure
import 'package:flutter_application_1/screens/navbar_screen.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:hive/hive.dart';

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
    var authBox = await Hive.openBox('authBox');
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
        MaterialPageRoute(builder: (context) => IntroductionScreen()),
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

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _currentIndex = 0;

  final List<String> _featureTexts = [
    "Welcome to our App!",
    "Easy ride sharing",
    "Track your trips in real-time",
  ];

  final List<String> _featureImages = [
    'images/feature0.png',
    'images/feature1.png',
    'images/feature2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _featureTexts.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      _featureImages[index],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 100,
                      left: 20,
                      right: 20,
                      child: Text(
                        _featureTexts[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Display "Get Started" button on the last page
                    if (index == _featureTexts.length - 1)
                      Positioned(
                        bottom: 40,
                        left: 50,
                        right: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the login screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFDC6D6), // Button color
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
