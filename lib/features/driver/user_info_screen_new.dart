import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import '../../data/api/api.dart';
import '../../domains/freezed/booking_model.dart';
import 'package:http/http.dart' as http;

import '../../services/fare_service/booking_controller.dart';

class UserInfoScreenNew extends HookConsumerWidget {
  const UserInfoScreenNew(this.user, {super.key});


  final UserModel user;


  @override
  Widget build(BuildContext context, WidgetRef ref) {


// State variables converted to useState
    final isWaitingForDecision = useState(true); // Initially, waiting for decision
    final isDealAccepted = useState(false); // Initially, no decision made
    final priceController = useTextEditingController(); // TextEditingController hook
    const double minPrice = 1000.0; // Minimum acceptable price (constant, no need for useState)
    const double maxPrice = 100000.0; // Maximum acceptable price (constant, no need for useState)
    final priceError = useState<String?>(null); // To show validation error

    // MapController is not stateful, so it can remain as a final variable
    final mapController = useMemoized(() => MapController());


    // Simulated driver's location (constant, no need for useState)
    const LatLng driverLocation = LatLng(51.5074, -0.1278); // Example: London coordinates

    // Mutable state for the current map center
    final currentCenter = useState(const LatLng(37.4222832, -122.083944));

    // Mutable list of points (useState for list)
    final points = useState<List<LatLng>>([]);

    // Mutable list of markers (useState for list)
    final selectedMarkers = useState<List<Marker>>([]);

    // Mutable strings for user location and destination
    final locationUser = useState<String>("");
    final destinationUser = useState<String>("");

    // Mutable string for amount
    final amount = useState<String>('');

    // Mutable boolean for whether the deal is active
    final isDeal = useState<bool>(false);

    // Example function to update state
    void updateDealStatus(bool status) {
      isDeal.value = status;
    }

    // Example function to update current center
    void updateCurrentCenter(LatLng newCenter) {
      currentCenter.value = newCenter;
    }

    Future<void> getCoordinates(String firstPick, String secondPick) async {
      try {
        var response = await http.get(getRouteUrl(firstPick, secondPick));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var listOfPoint = data['features'][0]['geometry']['coordinates'];

          // Update points and markers using useState hooks
          points.value = List<LatLng>.from(listOfPoint.map(
                  (point) => LatLng(point[1].toDouble(), point[0].toDouble())));

          // Add marker for driver location
          selectedMarkers.value = [
            const Marker(
              rotate: true,
              point: driverLocation,
              width: 40,
              height: 40,
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.red,
              ),
            ),
          ];
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lỗi tìm kiếm')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi tìm kiếm')),
        );
      }
    }


    // Function to search for locations
    Future<void> searchLocation(String location, String destination) async {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          double latLocation = double.parse(data[0]['lat']);
          double lonLocation = double.parse(data[0]['lon']);
          final url = Uri.parse(
              'https://nominatim.openstreetmap.org/search?q=$destination&format=json&limit=1');
          final response = await http.get(url);

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data.isNotEmpty) {
              double latDes = double.parse(data[0]['lat']);
              double lonDes = double.parse(data[0]['lon']);

              // Update state using useState hooks
              locationUser.value = "$lonLocation, $latLocation";
              destinationUser.value = "$lonDes, $latDes";

              // Call getCoordinates
              getCoordinates(locationUser.value, destinationUser.value);
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy vị trí')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi tìm kiếm vị trí')),
        );
      }
    }

    // Simulate driver decision
    Future<void> _simulateDriverDecision() async {
      // Simulate driver decision after some delay (e.g., 3 seconds)
      await Future.delayed(const Duration(seconds: 3));

      // Update state using useState hooks
      isWaitingForDecision.value = false;
      isDealAccepted.value = true; // Set to true if driver accepts, false otherwise
    }

    // Fetch coordinates based on location and destination

    // Validate and accept the deal
    void _validateAndAcceptDeal() async {
      final enteredPrice = double.tryParse(priceController.text);
      if (enteredPrice == null ||
          enteredPrice < 1000.0 || // Assuming _minPrice is 1000.0
          enteredPrice > 100000.0) { // Assuming _maxPrice is 100000.0
        priceError.value = 'Price must be between 1000.0 and 100000.0';
      } else {
        priceError.value = null; // Clear error if valid

        // Assume BookingController.addDriverAmount is an async method
        Map<String, dynamic> driverAmount =
        await BookingController(context: context).addDriverAmount(
            driverId: 123, // Replace with actual driverId
            amount: enteredPrice,
            bookingId: 456); // Replace with actual bookingId

        if (driverAmount.isNotEmpty) {

          Fluttertoast.showToast(
            msg: 'Đã đặt giá thành công: ${driverAmount['amount']}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );

          // Update amount and isDeal using useState hooks
          amount.value = driverAmount['amount'].toString();
          isDeal.value = false;
        }
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin ${user.username}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentCenter.value,
                initialZoom: 15.0,
                onPositionChanged: (camera, hasGesture) {

                    currentCenter.value = camera.center;

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
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points.value,
                      color: Colors.blue,
                      strokeWidth: 5.0,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // User Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Driver Image Section
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                // Driver Info Section
                Text(
                  user.username,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  user.phone,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                // Input price to deal with customer
                amount.value != '' && !isDeal.value
                    ? GestureDetector(
                  onTap: () {

                      isDeal.value = true;

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Giá thỏa thuận: ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            amount.value,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(
                        FontAwesomeIcons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
                    : TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Nhập giá thỏa thuận',
                      border: const OutlineInputBorder(),
                      errorText:
                      priceError.value, // Show error message if invalid
                      suffixIcon: IconButton(
                        icon: const Icon(FontAwesomeIcons.check),
                        onPressed: () {

                            isDeal.value = false;

                        },
                      )),
                ),
                const SizedBox(height: 20),
                // Action Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: isDealAccepted.value && isDeal.value
                        ? const Color(0xFFFDC6D6)
                        : Colors.grey,
                  ),
                  onPressed: isDealAccepted.value && isDeal.value
                      ? _validateAndAcceptDeal
                      : null, // Disable button if deal is not accepted
                  child: const Text('Chốt Deal Với Người Này',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
