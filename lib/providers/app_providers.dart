

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';


final tokenProvider = Provider<String>((ref) {
  throw UnimplementedError();
});

Future<String> getTokenFromHive() async {
  var box = Hive.box('authBox');
  String token = box.get('token', defaultValue: null);
  return token;
}