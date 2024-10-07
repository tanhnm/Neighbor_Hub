import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the IntroductionScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => IntroductionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/Logo.png',
            width: 150, height: 150), // Logo image
      ),
    );
  }
}

// Introduction Screen
class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _currentIndex = 0; // Keep track of the current page

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
                    // Full-screen image in the background
                    Image.asset(
                      _featureImages[index],
                      fit: BoxFit.cover, // Fills the screen
                    ),
                    // Overlay for text and other widgets
                    Container(
                      color: Colors
                          .black54, // Optional: Adds a semi-transparent overlay for better text visibility
                    ),
                    // Feature text in the foreground
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _featureTexts[index],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Page indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _featureTexts.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: _currentIndex == index ? 12.0 : 8.0,
                height: _currentIndex == index ? 12.0 : 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _currentIndex == _featureTexts.length - 1
                ? () {
                    // If the user is on the last page, navigate to the login screen
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                : null, // Disable the button if not on the last page
            child: Text("Get Started"),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
