import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/profile_me_screen.dart';
import 'package:flutter_application_1/splashScreen/splash_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // For getting the app directory
import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('authBox');
  await Hive.openBox('appBox');
  await Hive.openBox('locationBox');
  await Hive.openBox<User>('users');
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
      home: const SplashScreen(),
      routes: {
        '/profile': (context) =>
            const ProfileMeScreen(), // Define the route here
      },
    ));
  }
}
