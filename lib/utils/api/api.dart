const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248a8f8e5f2220c4bb9b344c7e70605aa67';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse(
      '${baseUrl}?api_key=$apiKey&start=$startPoint&end=$endPoint');
}
