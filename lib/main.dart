import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/splash/splash_screen.dart';
import 'package:flutter_application_1/providers/current_position_provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // For getting the app directory
import 'common/router.dart';
import 'features/auth/profile_me_screen.dart';
import 'domains/freezed/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('authBox');
  await Hive.openBox('appBox');
  await Hive.openBox('locationBox');
  await Hive.openBox<UserModel>('users');

  // Load the user from Hive before running the app

  runApp(
    const ProviderScope(
      overrides: [],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    // ref.watch(hiveInitializationProvider);
    return ToastificationWrapper(
        child: MaterialApp.router(
      routerConfig: goRouter,
      title: 'Mapbox Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
    ));
  }
}
