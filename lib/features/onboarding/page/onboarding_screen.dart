import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/onboarding/onboarding_items.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset('assets/lottie/animation_bike.json'),
    );
  }
}
