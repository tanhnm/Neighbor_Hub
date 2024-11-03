abstract class Routes {
  static const home = '/';
  static const destinationPick = 'destinationPick';

  static const activity = '/activity';
  static const driverList = 'driverList';

  static const settings = '/settings';

}

extension RouteName on String {
  String get name => substring(1);
}