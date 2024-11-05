abstract class Routes {
  static const home = '/';
  static const splash = '/splash';
  static const login = '/login';


  static const destinationPick = 'destinationPick';
  static const mapDriver = 'mapDriver';
  static const map = 'map';

  static const activity = '/activity';
  static const driverList = 'driverList';
  static const message = 'message';

  static const settings = '/settings';
  static const profile = 'profile';

  static const userList = '/userList';
  static const messageDriver = 'messageDriver';

  static const regForm = '/regForm';

}

extension RouteName on String {
  String get name => substring(1);
}