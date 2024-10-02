import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/api/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Add this import at the top
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const MapScreen(
      {super.key,
      required this.initialLatitude,
      required this.initialLongitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer? _nearbyPlacesTimer; // Timer variable
  List<LatLng> points = [];
  List listOfPoint = [];
  String firstPick = '';
  String secondPick = '';
  bool firstPickDone = false;

  final MapController _mapController = MapController();
  late LatLng _currentCenter;

  List<Marker> selectedMarkers = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  List<Map<String, String>> vehicles = [
    {'type': 'Sedan', 'model': 'Toyota Camry', 'price': '\$20'},
    {'type': 'SUV', 'model': 'Honda CR-V', 'price': '\$30'},
    {'type': 'Bike', 'model': 'Yamaha YZF-R15', 'price': '\$10'},
    {'type': 'Luxury', 'model': 'Mercedes S-Class', 'price': '\$50'},
  ];

  String selectedVehicle = '';

  @override
  void initState() {
    super.initState();
    _currentCenter = LatLng(widget.initialLatitude, widget.initialLongitude);
    firstPick = "${_currentCenter.longitude}, ${_currentCenter.latitude}";
    selectedMarkers.add(
      Marker(
        rotate: true,
        point: _currentCenter,
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

  getCoordinates(String firstPick, String secondPick) async {
    // Call the API with reversed coordinates
    var response = await http.get(getRouteUrl(firstPick, secondPick));

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

  Future<void> searchLocation(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        double lat = double.parse(data[0]['lat']);
        double lon = double.parse(data[0]['lon']);
        LatLng newLocation = LatLng(lat, lon);

        setState(() {
          _mapController.move(newLocation, 15.0);
          _currentCenter = newLocation;
          selectedMarkers.add(
            Marker(
              rotate: true,
              point: newLocation,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.red,
              ),
            ),
          );
        });
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

  Future<void> getSuggestions(String query) async {
    double delta = 0.1; // Size of the bounding box
    double southWestLat = _currentCenter.latitude - delta;
    double southWestLon = _currentCenter.longitude - delta;
    double northEastLat = _currentCenter.latitude + delta;
    double northEastLon = _currentCenter.longitude + delta;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&bounded=1&viewbox=$southWestLon,$northEastLat,$northEastLon,$southWestLat');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      setState(() {
        _suggestions = data.map((item) {
          double suggestionLat = double.parse(item['lat']);
          double suggestionLon = double.parse(item['lon']);
          double distance = Geolocator.distanceBetween(
            _currentCenter.latitude,
            _currentCenter.longitude,
            suggestionLat,
            suggestionLon,
          );

          return {
            "display_name": item['display_name'],
            "lat": suggestionLat,
            "lon": suggestionLon,
            "distance": distance, // Add the calculated distance
          };
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi gợi ý vị trí')),
      );
    }
  }

  void _pickLocation() {
    setState(() {
      firstPickDone = true;
      if (firstPickDone) {
        secondPick = "${_currentCenter.longitude}, ${_currentCenter.latitude}";
      }
      if (selectedMarkers.length < 2) {
        // Add new marker
        selectedMarkers.add(
          Marker(
            rotate: true,
            point: _currentCenter,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: Color.fromARGB(255, 255, 0, 34),
            ),
          ),
        );

        // After picking the second location, call the API
        getCoordinates(firstPick, secondPick);
      } else {
        // If 2 markers already exist, clear them and allow new picks
        selectedMarkers.removeAt(1);
        points = [];
        firstPickDone = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn vị trí trên bản đồ'),
      ),
      body: GestureDetector(
          onTap: () {
            setState(() {
              selectedVehicle =
                  ''; // Reset selected vehicle when user taps outside
            });
          },
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentCenter,
                  initialZoom: 15.0,
                  onPositionChanged: (camera, hasGesture) {
                    setState(() {
                      selectedVehicle = '';
                      _currentCenter = camera.center;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              firstPickDone
                  ? Container()
                  : const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Column(children: [
                  // Search input and suggestions code here...
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              firstPickDone
                  ? Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 224, 224),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Choose Vehicle",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: vehicles.length,
                                  itemBuilder: (context, index) {
                                    final vehicle = vehicles[index];
                                    bool isSelected =
                                        vehicle['model'] == selectedVehicle;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedVehicle = vehicle['model']!;
                                        });
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        elevation: 5,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                vehicle['type']!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(vehicle['model']!),
                                              const SizedBox(height: 5),
                                              Text(vehicle['price']!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )),
      floatingActionButtonLocation: CustomFabLocation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _mapController.move(
                LatLng(widget.initialLatitude, widget.initialLongitude), 15.0);
          });
        },
        child: const Icon(Icons.my_location),
      ),
      bottomNavigationBar: selectedVehicle.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your confirm vehicle action here
                  print("Confirmed vehicle: $selectedVehicle");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Confirm Vehicle",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thêm Chi Tiết Điểm Đến',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.add_circle,
                            color: Colors.blue,
                          ),
                        ]),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width:
                        double.infinity, // Makes the button take up full width
                    child: ElevatedButton(
                      onPressed: _pickLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Same as Confirm button
                        padding: const EdgeInsets.symmetric(
                            vertical: 15), // Ensure vertical padding
                      ),
                      child: selectedMarkers.length == 2
                          ? const Text(
                              'Clear',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          : const Text(
                              "Choose Location",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double x = scaffoldGeometry.scaffoldSize.width * 0.9 - 28;
    double y = scaffoldGeometry.scaffoldSize.height * 0.70 - 28;
    return Offset(x, y);
  }
}
