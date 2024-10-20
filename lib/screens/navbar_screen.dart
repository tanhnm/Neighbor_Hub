import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/driver_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/Driver/registration_form_screen.dart';
import 'package:flutter_application_1/screens/Driver/user_list_screen.dart';
import 'package:flutter_application_1/screens/activity_screen.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final DriverService driverService = DriverService();
  int currentIndex = 0;
  bool is_driver = false;

  List<dynamic> screens = [
    const MainScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
    UserListScreen(),
    RegistrationFormScreen()
    // UserListScreen() will be conditionally added
  ];

  @override
  void initState() {
    super.initState();
    _checkDriver(); // Check driver when the state initializes
  }

  Future<void> _checkDriver() async {
    var userBox = await Hive.openBox<User>('users');
    String? phoneNumber = userBox.get('user')?.phone;
    var box = await Hive.openBox('authBox');
    await driverService.getDriverByPhoneNumber(phoneNumber!);
    // Assuming you have this method to get the current driver
    is_driver = box.get('is_driver', defaultValue: false);
    print('is_driver: $is_driver');
    if (is_driver) {
      setState(() {
        is_driver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          elevation: 1,
          color: const Color(0xFFEF3167),
          height: 60,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: Icon(FontAwesomeIcons.house,
                    size: 30,
                    color: currentIndex == 0 ? Colors.white : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(FontAwesomeIcons.clock,
                    size: 30,
                    color: currentIndex == 1 ? Colors.white : Colors.black),
              ),
              if (is_driver) // Only show if driver is not null
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.mapLocation,
                      size: 30,
                      color: currentIndex == 3 ? Colors.white : Colors.black),
                ),
              if (is_driver)
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.addressCard,
                      size: 30,
                      color: currentIndex == 4 ? Colors.white : Colors.black),
                ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(FontAwesomeIcons.user,
                    size: 30,
                    color: currentIndex == 2 ? Colors.white : Colors.black),
              ),
            ],
          )),
      body: screens[currentIndex],
    );
  }
}
