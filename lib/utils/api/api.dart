import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf624853dcdcf9527f4827b2883acc750b65da';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

Future<String?> getHiveLocal(String key) async {
  var box = await Hive.openBox('authBox');
  String? value = await box.get(key, defaultValue: null);
  return value;
}

Future<String> getPlaceName(String latitude, String longitude) async {
  final String url =
      'https://api.openrouteservice.org/geocode/reverse?api_key=$apiKey&point.lat=$latitude&point.lon=$longitude&size=1';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['features'] != null && data['features'].isNotEmpty) {
      final placeName = data['features'][0]['properties']['label'];
      return placeName;
    } else {
      return 'No place found';
    }
  } else {
    print(response.body);
    return 'Error: ${response.statusCode}';
  }
}
