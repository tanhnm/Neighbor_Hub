import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart'; // Adjust this import based on your project structure

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  List<Image> _featureImages = [];
  int _currentIndex = 0;

  final List<String> _featureTexts = [
    "Welcome to our App!",
    "Easy ride sharing",
    "Track your trips in real-time",
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the images
    _featureImages = [
      Image.asset('images/feature0.png', fit: BoxFit.cover),
      Image.asset('images/feature1.png', fit: BoxFit.cover),
      Image.asset('images/feature2.png', fit: BoxFit.cover),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload images after dependencies are available
    for (var image in _featureImages) {
      precacheImage(image.image, context);
    }
  }

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
                    _featureImages[index],
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
