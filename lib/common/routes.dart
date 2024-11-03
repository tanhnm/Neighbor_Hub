abstract class Routes {
  static const home = '/';
  static const splash = '/splash';
  static const login = '/login';



  static const destinationPick = 'destinationPick';

  static const activity = '/activity';
  static const driverList = 'driverList';

  static const settings = '/settings';
  static const profile = 'profile';

}

extension RouteName on String {
  String get name => substring(1);
}