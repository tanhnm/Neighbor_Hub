import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/vnpay/vnpay.dart';
import 'package:flutter_application_1/common/widgets/voucher/voucher_list_page.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/destination_pick.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/map_screen.dart';
import 'package:flutter_application_1/screens/PaymentScreen/payment_method_screen.dart';
import 'package:flutter_application_1/screens/auth/login_password_screen.dart';
import 'package:flutter_application_1/screens/confirm_otp_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_application_1/splashScreen/splash_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toastification/toastification.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // For getting the app directory
import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(UserAdapter()); // Register the adapter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp(
      title: 'Mapbox Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: LoginScreen(),
    ));
  }
}
