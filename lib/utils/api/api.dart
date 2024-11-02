import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248f761334819b74c4c8676159cce89879f';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

Future<String?> getHiveLocal(String key) async {
  var box = Hive.box('authBox');
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
    return 'Error: ${response.statusCode}';
  }
}

Future<List<dynamic>> getNearbyPlaces(double latitude, double longitude) async {
  final url =
      'https://api.openrouteservice.org/geocode/reverse?api_key=$apiKey&point.lon=$longitude&point.lat=$latitude&size=5';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<dynamic> features = data['features'];
    List<String> labels = features
        .map((feature) => feature['properties']['label'] as String)
        .toList();
    return labels; // Returns the list of nearby places
  } else {
    throw Exception('Failed to load nearby places');
  }
}
