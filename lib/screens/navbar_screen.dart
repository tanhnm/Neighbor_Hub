import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/activity_screen.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  List screens = const [MainScreen(), ActivityScreen(), ProfileScreen()];
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
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(FontAwesomeIcons.user,
                    size: 30,
                    color: currentIndex == 2 ? Colors.white : Colors.black),
              )
            ],
          )),
      body: screens[currentIndex],
    );
  }
}
