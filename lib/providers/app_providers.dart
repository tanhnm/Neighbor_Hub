

import 'package:flutter_application_1/common/restaurants.dart';
import 'package:flutter_application_1/data/api/app_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'dio_provider.dart';


final tokenProvider = Provider<String>((ref) {
  throw UnimplementedError();
});

Future<String?> getTokenFromHive() async {
  var box = Hive.box('authBox');
  String? token = box.get('token', defaultValue: null);
  return token;
}


Provider<AppApi> appApiProvider = Provider<AppApi>(
      (ref) => AppApi(
    ref.watch(dioProvider),
    baseUrl: kBaseHttpUrl,
  ),
);