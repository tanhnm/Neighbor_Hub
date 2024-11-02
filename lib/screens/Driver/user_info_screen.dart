import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/api/api.dart';
import 'dart:convert';

import 'package:toastification/toastification.dart';

class UserInfoScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final Booking booking;

  const UserInfoScreen({super.key, required this.user, required this.booking});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool _isWaitingForDecision = true; // Initially, waiting for decision
  bool _isDealAccepted = false; // Initially, no decision made
  final TextEditingController _priceController = TextEditingController();
  final double _minPrice = 1000.0; // Minimum acceptable price
  final double _maxPrice = 100000.0; // Maximum acceptable price
  String? _priceError; // To show validation error
  final MapController _mapController = MapController();

  // Simulated driver's location
  final LatLng _driverLocation =
      const LatLng(51.5074, -0.1278); // Example: London coordinates
  LatLng _currentCenter = const LatLng(37.4222832, -122.083944);
  List<LatLng> points = []; // List to hold the route points
  List<Marker> selectedMarkers = []; // List to hold the markers

  String locationUser = "";
  String destinationUser = "";
  String amount = '';
  bool isDeal = false;
  @override
  void initState() {
    super.initState();
    _simulateDriverDecision(); // Start simulating the driver's decision
    searchLocation(widget.user['location'], widget.user['destination']);
  }

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
            setState(() {
              locationUser = "$lonLocation, $latLocation";
              destinationUser = "$lonDes, $latDes";
            });
            getCoordinates(locationUser, destinationUser);
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

  Future<void> _simulateDriverDecision() async {
    // Simulate driver decision after some delay (e.g., 3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isWaitingForDecision = false;
      // You can set this to true or false based on the driver's decision
      _isDealAccepted = true; // Set to true if driver accepts, false otherwise
    });

    // Fetch route coordinates after decision simulation
  }

  Future<void> getCoordinates(String firstPick, String secondPick) async {
    // Call the API with reversed coordinates
    try {
      var response = await http.get(getRouteUrl(firstPick, secondPick));

      setState(() {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var listOfPoint = data['features'][0]['geometry']['coordinates'];

          // Ensure points are of type List<LatLng>
          points = List<LatLng>.from(listOfPoint.map(
              (point) => LatLng(point[1].toDouble(), point[0].toDouble())));

          // Set marker for driver location
          selectedMarkers.add(
            Marker(
              rotate: true,
              point: _driverLocation,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.red,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lỗi tìm kiếm')),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi tìm kiếm')),
      );
    }
  }

  void _validateAndAcceptDeal() async {
    final enteredPrice = double.tryParse(_priceController.text);
    if (enteredPrice == null ||
        enteredPrice < _minPrice ||
        enteredPrice > _maxPrice) {
      setState(() {
        _priceError = 'Price must be between $_minPrice and $_maxPrice';
      });
    } else {
      setState(() {
        _priceError = null; // Clear error if valid
      });
      Map<String, dynamic> driverAmount =
          await BookingController(context: context).addDriverAmount(
              driverId: widget.booking.driverId,
              amount: enteredPrice,
              bookingId: widget.booking.booking.bookingId);
      if (driverAmount.isNotEmpty) {
        toastification.show(
          context: context,
          style: ToastificationStyle
              .flat, // optional if you use ToastificationWrapper
          title: Text('Đã đặt giá thành công: ${driverAmount['amount']}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
        setState(() {
          amount = driverAmount['amount'].toString();
          isDeal = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin ${widget.user['username']}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentCenter,
                initialZoom: 15.0,
                onPositionChanged: (camera, hasGesture) {
                  setState(() {
                    _currentCenter = camera.center;
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
                  widget.user['username'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.user['phone'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.user['email'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                // Input price to deal with customer
                amount != '' && !isDeal
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isDeal = true;
                          });
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
                                  amount,
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
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Nhập giá thỏa thuận',
                            border: const OutlineInputBorder(),
                            errorText:
                                _priceError, // Show error message if invalid
                            suffixIcon: IconButton(
                              icon: const Icon(FontAwesomeIcons.check),
                              onPressed: () {
                                setState(() {
                                  isDeal = false;
                                });
                              },
                            )),
                      ),
                const SizedBox(height: 20),
                // Action Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: _isDealAccepted && isDeal
                        ? const Color(0xFFFDC6D6)
                        : Colors.grey,
                  ),
                  onPressed: _isDealAccepted && isDeal
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
