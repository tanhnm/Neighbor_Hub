import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/api/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List listOfPoint = [];
  List<LatLng> points = [];
  MapController _mapController = MapController();
  LatLng _currentCenter = LatLng(6.145332, 1.243344); // Initial center

  List<Marker> selectedMarkers = [];
  String firstPick = '';
  String secondPick = '';

  bool firstPickDone = false;

  getCoordinates(String firstPick, String secondPick) async {
    // Call the API with reversed coordinates
    var response = await http.get(getRouteUrl(firstPick, secondPick));

    print('call');
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoint = data['features'][0]['geometry']['coordinates'];
        points = listOfPoint
            .map((e) => LatLng(e[1].toDouble(),
                e[0].toDouble())) // Reverse them back for the map
            .toList();
      }
    });
  }

  void _pickLocation() {
    setState(() {
      if (firstPickDone == false) {
        firstPick = "${_currentCenter.longitude}, ${_currentCenter.latitude}";
      } else {
        secondPick = "${_currentCenter.longitude}, ${_currentCenter.latitude}";
      }
      if (selectedMarkers.length < 2) {
        firstPickDone = true;
        // Add new marker
        selectedMarkers.add(
          Marker(
            point: _currentCenter,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: Colors.blue,
            ),
          ),
        );

        // After picking the second location, call the API
        if (selectedMarkers.length == 2) {
          getCoordinates(firstPick, secondPick);
        }
      } else {
        // If 2 markers already exist, clear them and allow new picks
        selectedMarkers.clear();
        firstPickDone = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Point on the Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 13.0,
              onPositionChanged: (mapPosition, hasGesture) {
                // Update center when map moves
                if (hasGesture) {
                  setState(() {
                    _currentCenter = _mapController.camera.center;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: selectedMarkers, // Show picked markers
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.blue,
                    strokeWidth: 5.0,
                  ),
                ],
              ),
            ],
          ),
          // Crosshair icon at the center
          Align(
            alignment: Alignment.center,
            child: const Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.red,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _pickLocation,
          child: Text(
              firstPickDone ? 'Pick Second Location' : 'Pick First Location'),
        ),
      ),
    );
  }
}
