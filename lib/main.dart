import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/voucher/voucher_list_page.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/destination_pick.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/map_screen.dart';
import 'package:flutter_application_1/screens/PaymentScreen/payment_method_screen.dart';
import 'package:flutter_application_1/screens/auth/login_password_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: LoginScreen(),
    );
  }
}
