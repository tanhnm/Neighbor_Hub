import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/profile_me_screen.dart';
import 'package:flutter_application_1/features/booking_car/destination_pick.dart';
import 'package:flutter_application_1/features/home/main_page_new.dart';
import 'package:flutter_application_1/features/temp_screen/activity_screen.dart';
import 'package:flutter_application_1/features/temp_screen/activity_screen_new.dart';
import 'package:flutter_application_1/features/temp_screen/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/booking_car/destination_pick_new.dart';
import '../features/booking_car/driver_list_screen.dart';
import '../features/home/main_page.dart';
import '../features/splash/splash_screen.dart';
import '../features/temp_screen/login_screen.dart';
import '../providers/user_provider.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    redirect: (context, state) async {
      // Check if the user is logged in
      final isLoggedIn = await isUserLoggedIn();

      // If the user is trying to access a protected route and is not logged in, redirect to login
      if (!isLoggedIn && state.matchedLocation != Routes.login) {
        return Routes.login;
      }

      // If the user is logged in and tries to go to the login page, redirect to home
      if (isLoggedIn && state.matchedLocation == Routes.login) {
        return Routes.home;
      }

      // No need to redirect if the user is on the correct route
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: [
            //home
            StatefulShellBranch(navigatorKey: _sectionANavigatorKey, routes: [
              GoRoute(
                  path: Routes.home,
                  name: Routes.home,
                  builder: (context, state) => const MainPageNew(),
                  routes: [
                    GoRoute(
                      path: Routes.destinationPick,
                      name: Routes.destinationPick,
                      builder: (context, state) => const DestinationPickNew(),
                    ),
                  ]),
            ]),

            //activity
            StatefulShellBranch(routes: [
              GoRoute(
                  path: Routes.activity,
                  name: Routes.activity,
                  builder: (context, state) => const ActivityScreenNew(),
                  routes: [
                    GoRoute(
                        path: Routes.driverList,
                        name: Routes.driverList,
                        builder: (context, state) {
                          final Map<String, dynamic> booking =
                              state.extra as Map<String, dynamic>;
                          return DriverListScreen(booking: booking);
                        }),
                  ]),
            ]),

            //settings
            StatefulShellBranch(routes: [
              GoRoute(
                  path: Routes.settings,
                  name: Routes.settings,
                  builder: (context, state) => const SettingScreen(),
                  routes: [
                    GoRoute(
                      path: Routes.profile,
                      name: Routes.profile,
                      builder: (context, state) => const ProfileMeScreen(),
                    ),
                  ]),
            ]),
          ]),
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
});

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() {
      ref.read(navigationShellProvider.notifier).state = navigationShell;
    });
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
            child: GNav(
              gap: 10,
              color: Colors.grey[600],
              activeColor: Colors.white,
              rippleColor: Colors.grey[800]!,
              hoverColor: Colors.grey[700]!,
              iconSize: 20,
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
              tabBackgroundColor: Colors.grey[900]!,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
              duration: Duration(milliseconds: 800),
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.wandMagicSparkles,
                  text: 'Home',
                  borderRadius: BorderRadius.circular(12),
                ),
                GButton(
                  icon: FontAwesomeIcons.gun,
                  text: 'Activity',
                  borderRadius: BorderRadius.circular(12),
                ),
                GButton(
                  icon: FontAwesomeIcons.house,
                  borderRadius: BorderRadius.circular(12),
                  text: 'Settings',
                ),
              ],
              selectedIndex: navigationShell.currentIndex,
              onTabChange: (index) => _onTap(context, index),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

final navigationShellProvider =
    StateProvider<StatefulNavigationShell?>((ref) => null);
