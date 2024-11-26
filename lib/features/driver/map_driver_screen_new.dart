import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';

import '../../services/driver_service/driver_service.dart';

class MapDriverScreenNew extends HookConsumerWidget {
  const MapDriverScreenNew(
      {super.key, required this.driverId, required this.registrationID,
        required this.registrationStatus, required this.lat, required this.lon,});

  final int driverId;
  final int registrationID;
  final int registrationStatus;
  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(() => MapController());
    final selectedMarkers = useState<List<Marker>>([]);
    final isActive = useState(registrationStatus == 0 ? false : true);
    final currentLocation = useState(LatLng(lat, lon));

    Future<void> toggleActiveStatus() async {
      try {
        if (isActive.value) {
          // Deactivate the driver
          final bool success =
              await DriverService().deactivateDriver(registrationID);
          if (!success) {
            Fluttertoast.showToast(
              msg: 'Failed to deactivate!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'You are now inactive!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );

            isActive.value = !isActive.value;
          }
        } else {
          // Activate the driver
          final bool success = await DriverService().activateDriver(
            registrationId: registrationID,
            lat: currentLocation.value.latitude,
            lon: currentLocation.value.longitude,
          );
          if (success) {
            Fluttertoast.showToast(
              msg: 'You are now active!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );
            isActive.value = !isActive.value;
          } else {
            Fluttertoast.showToast(
              msg: 'Failed to activate!',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );
          }
          // Automatically deactivate after 10 seconds
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Failed to toggle active status',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );
      }
    }

    void searchPlaces() {
      // Implement search functionality here
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Map'),
        actions: [
          IconButton(
            icon:
                Icon(isActive.value ? Icons.visibility_off : Icons.visibility),
            onPressed: toggleActiveStatus,
          ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation.value,
          initialZoom: 15.0,
          onPositionChanged: (camera, hasGesture) {
            currentLocation.value = camera.center;
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: selectedMarkers.value,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: searchPlaces,
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEF3167),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: toggleActiveStatus,
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive.value
                  ? const Color.fromARGB(255, 7, 4, 4)
                  : Colors.green,
            ),
            child: Text(
              isActive.value ? 'Deactivate' : 'Activate',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
