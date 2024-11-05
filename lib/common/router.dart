import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/booking_model.dart';
import 'package:flutter_application_1/features/auth/profile_me_screen.dart';
import 'package:flutter_application_1/features/booking_car/message_screen_new.dart';
import 'package:flutter_application_1/features/driver/map_driver_screen_new.dart';
import 'package:flutter_application_1/features/driver/message_screen_driver_new.dart';
import 'package:flutter_application_1/features/driver/registration_form_screen.dart';
import 'package:flutter_application_1/features/driver/user_list_screen_new.dart';
import 'package:flutter_application_1/features/home/main_page_new.dart';
import 'package:flutter_application_1/features/temp_screen/activity_screen_new.dart';
import 'package:flutter_application_1/features/temp_screen/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domains/freezed/booking_detail_model.dart';
import '../features/auth/profile_screen_new.dart';
import '../features/booking_car/destination_pick_new.dart';
import '../features/booking_car/driver_list_screen_new.dart';
import '../features/booking_car/map_screen_new.dart';
import '../features/splash/splash_screen.dart';
import '../features/temp_screen/login_screen.dart';
import '../providers/user_provider.dart';
import 'routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
                        routes: [
                          GoRoute(
                              path: Routes.mapDriver,
                              name: Routes.mapDriver,
                              builder: (context, state) {
                                final extraData =
                                    state.extra as Map<String, dynamic>;
                                final driverId = extraData['driverId'] as int;
                                final registrationID =
                                    extraData['registrationID'] as int;
                                final registrationStatus =
                                    extraData['registrationStatus'] as int;
                                final lat = extraData['lat'] as double;
                                final lon = extraData['lon'] as double;
                                return MapDriverScreenNew(
                                    driverId: driverId,
                                    registrationID: registrationID,
                                    registrationStatus: registrationStatus,
                                    lat: lat,
                                    lon: lon);
                              }),
                          GoRoute(
                              path: Routes.map,
                              name: Routes.map,
                              builder: (context, state) {
                                final extraData =
                                    state.extra as Map<String, dynamic>;
                                final initialLatitude =
                                    extraData['initialLatitude'] as double;
                                final initialLongitude =
                                    extraData['initialLongitude'] as double;
                                return MapScreenNew(
                                    initialLatitude: initialLatitude,
                                    initialLongitude: initialLongitude);
                              }),
                        ]),
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
                          final BookingDetailModel bookingDetail =
                              state.extra as BookingDetailModel;
                          return DriverListScreenNew(
                              bookingDetail: bookingDetail);
                        },
                        routes: [

                          GoRoute(
                            path: Routes.message,
                            name: Routes.message,
                            builder: (context, state) {
                              final BookingDetailModel bookingDetail =
                                  state.extra as BookingDetailModel;
                              return MessageScreenNew(
                                  bookingDetail: bookingDetail);
                            },
                          ),
                        ]),
                    GoRoute(
                      path: Routes.profileDriver,
                      name: Routes.profileDriver,
                      builder: (context, state) {
                        final BookingDetailModel bookingDetail =
                            state.extra as BookingDetailModel;
                        return ProfileScreenNew(
                            bookingDetail: bookingDetail);
                      },
                    ),
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
            StatefulShellBranch(routes: [
              GoRoute(
                  path: Routes.userList,
                  name: Routes.userList,
                  builder: (context, state) => const UserListScreenNew(),
                  routes: [
                    GoRoute(
                        path: Routes.messageDriver,
                        name: Routes.messageDriver,
                        builder: (context, state) {
                          final BookingModel booking =
                              state.extra as BookingModel;
                          return MessageScreenDriverNew(booking: booking);
                        }),
                  ]),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: Routes.regForm,
                  name: Routes.regForm,
                  builder: (context, state) => const RegistrationFormScreen(),
                  routes: []),
            ]),
          ]),
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
});

class ScaffoldWithNavBar extends HookConsumerWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDriver = useState(false);

    // Load the driver status once when the widget is first built
    useEffect(() {
      Future<void> loadDriverStatus() async {
        final driverStatus = await ref.read(driverProvider.future);
        isDriver.value = driverStatus != null;
      }

      loadDriverStatus();

      return null; // No cleanup needed
    }, []);

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
                  icon: FontAwesomeIcons.house,
                  borderRadius: BorderRadius.circular(12),
                ),
                GButton(
                  icon: FontAwesomeIcons.chartLine,
                  borderRadius: BorderRadius.circular(12),
                ),
                GButton(
                  icon: FontAwesomeIcons.gears,
                  borderRadius: BorderRadius.circular(12),
                ),
                if (isDriver.value)
                  GButton(
                    icon: FontAwesomeIcons.user,
                    borderRadius: BorderRadius.circular(12),
                  ),
                if (isDriver.value)
                  GButton(
                    icon: FontAwesomeIcons.paperclip,
                    borderRadius: BorderRadius.circular(12),
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
