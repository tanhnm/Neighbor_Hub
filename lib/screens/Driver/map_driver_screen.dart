import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:toastification/toastification.dart';

class MapDriverScreen extends StatefulWidget {
  final int driverId;
  final int registrationID;
  final int registrationStatus;
  final double lat;
  final double lon;

  const MapDriverScreen(
      {super.key,
      required this.driverId,
      required this.registrationID,
      required this.lat,
      required this.lon,
      required this.registrationStatus});

  @override
  _MapDriverScreenState createState() => _MapDriverScreenState();
}

class _MapDriverScreenState extends State<MapDriverScreen> {
  late MapController _mapController;
  List<Marker> selectedMarkers = [];
  bool _isActive = false;
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _isActive = widget.registrationStatus == 0 ? false : true;
    _currentLocation = LatLng(widget.lat, widget.lon);
    _mapController = MapController();
    selectedMarkers.add(
      Marker(
        rotate: true,
        point: _currentLocation,
        width: 30,
        height: 30,
        child: const Icon(
          FontAwesomeIcons.locationCrosshairs,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Map'),
        actions: [
          IconButton(
            icon: Icon(_isActive ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleActiveStatus,
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation,
          initialZoom: 15.0,
          onPositionChanged: (camera, hasGesture) {
            setState(() {
              _currentLocation = camera.center;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: selectedMarkers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchPlaces,
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEF3167),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _toggleActiveStatus,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isActive ? const Color.fromARGB(255, 7, 4, 4) : Colors.green,
            ),
            child: Text(
              _isActive ? 'Deactivate' : 'Activate',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleActiveStatus() async {
    try {
      if (_isActive) {
        // Deactivate the driver
        final bool success =
            await DriverService().deactivateDriver(widget.registrationID);
        if (!success) {
          toastification.show(
            context: context,
            style: ToastificationStyle.flat,
            title: const Text('Failed to deactivate!',
                style: TextStyle(color: Colors.white)),
            autoCloseDuration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          );
        } else {
          toastification.show(
            context: context,
            style: ToastificationStyle.flat,
            title: const Text('You are now inactive!',
                style: TextStyle(color: Colors.white)),
            autoCloseDuration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          );
          setState(() {
            _isActive = !_isActive;
          });
        }
      } else {
        // Activate the driver
        final bool success = await DriverService().activateDriver(
          registrationId: widget.registrationID,
          lat: _currentLocation.latitude,
          lon: _currentLocation.longitude,
        );
        if (success) {
          toastification.show(
            context: context,
            style: ToastificationStyle.flat,
            title: const Text('You are now active!'),
            autoCloseDuration: const Duration(seconds: 5),
            backgroundColor: Colors.green,
          );
          setState(() {
            _isActive = !_isActive;
          });
        } else {
          toastification.show(
            context: context,
            style: ToastificationStyle.flat,
            title: const Text('Failed to activate!'),
            autoCloseDuration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          );
        }
        // Automatically deactivate after 10 seconds
      }
    } catch (e) {
      print('Error toggling active status: $e');
    }
  }

  void _searchPlaces() {
    // Implement search functionality here
  }
}
