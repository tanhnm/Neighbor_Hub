import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/trip.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:flutter_application_1/services/fare_service/fare_controller.dart';
import 'package:flutter_application_1/utils/api/api.dart';
import 'package:flutter_application_1/utils/api/convertDistance/convert_distance.dart';
import 'package:flutter_application_1/utils/api/convertPrice/conver_price.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // Add this import at the top
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

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
  bool isPreBooking = false;
  double farePrice = 0.0;
  double distance = 0.0;
  double duration = 0.0;
  bool isLoading = false; // Add this to manage loading state
  DateTime? bookingDateTime;

  final MapController _mapController = MapController();
  late LatLng _currentCenter;

  List<Marker> selectedMarkers = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _suggestions = [];
  List<Map<String, String>> vehicles = [];
  String dropLocation = '';
  String pickLocation = '';
  User? user;

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

    _loadUser();
  }

  Future<void> _loadUser() async {
    var userBox = Hive.box<User>('users');
    user = userBox.get('user');
  }

  getCoordinates(String firstPick, String secondPick) async {
    // Call the API with reversed coordinates
    List<String> placeName = firstPick.split(',');
    pickLocation = await getPlaceName(placeName[1], placeName[0]);
    try {
      isLoading = true;
      var response = await http.get(getRouteUrl(firstPick, secondPick));

      setState(() {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          listOfPoint = data['features'][0]['geometry']['coordinates'];
          distance =
              data['features'][0]['properties']['segments'][0]['distance'];
          duration =
              data['features'][0]['properties']['segments'][0]['duration'];
          points = listOfPoint
              .map((e) => LatLng(e[1].toDouble(),
                  e[0].toDouble())) // Reverse them back for the map
              .toList();
        } else {
          toastification.show(
            context: context,
            style: ToastificationStyle
                .flat, // optional if you use ToastificationWrapper
            title: Text('Error response: ${response.body}'),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      });
      List<Trip> trips = await FareController(context: context)
          .getFare(distance: distance, travelTime: duration);
      for (var trip in trips) {
        vehicles.add({
          'type': trip.vehicleType,
          'distance': '$distance',
          'duration': '${trip.travelTimeSeconds}',
          'price': trip.tripCost.toString()
        });
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle
            .flat, // optional if you use ToastificationWrapper
        title: Text('Error: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

  void _onSearchChanged(String value) {
    if (value.isNotEmpty) {
      getSuggestions(value); // Fetch suggestions as the user types
    } else {
      setState(() {
        _suggestions = []; // Clear suggestions if search field is empty
      });
    }
  }

  void _onSuggestionTapped(Map<String, dynamic> suggestion) {
    _searchController.text = suggestion['display_name'];
    searchLocation(suggestion['display_name']);
    setState(() {
      _suggestions = []; // Clear suggestions after selection
    });
  }

  void _pickLocation() async {
    firstPickDone = true;
    if (firstPickDone) {
      secondPick = "${_currentCenter.longitude}, ${_currentCenter.latitude}";
    }

    dropLocation = await getPlaceName(_currentCenter.latitude.toString(),
        _currentCenter.longitude.toString());

    setState(() {
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
              const ButtonBottom(),
              // Search Bar
              Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: 'Tìm địa điểm gần đây...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                searchLocation(_searchController.text);
                              },
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
              // Suggestions List
              if (_suggestions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true, // Make the list view scrollable
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion['display_name']),
                        subtitle: Text(
                            '${suggestion['distance'].toStringAsFixed(2)} meters away'),
                        onTap: () {
                          _onSuggestionTapped(suggestion);
                        },
                      );
                    },
                  ),
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
                                "Chọn Loại Phương Tiện",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              isLoading
                                  ? Center(
                                      child: LoadingAnimationWidget.waveDots(
                                          color: Colors.black, size: 30))
                                  : Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: vehicles.length,
                                        itemBuilder: (context, index) {
                                          final vehicle = vehicles[index];
                                          bool isSelected = vehicle['type'] ==
                                              selectedVehicle;

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedVehicle =
                                                    vehicle['type']!;
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
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
                                                    Text(convertToKilometers(
                                                        vehicle['distance']!)),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        formatPriceFromString(
                                                            vehicle['price']!),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.green)),
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
                  // Show a modal dialog asking for booking details
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      bool isPreBooking =
                          false; // Local state inside the dialog
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: const Text('Xác Nhận Tìm Xe'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Bạn có muốn đặt trước xe không?'),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Đặt trước'),
                                    Switch(
                                      value: isPreBooking,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isPreBooking = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                if (isPreBooking)
                                  Column(
                                    children: [
                                      const Text('Chọn ngày và giờ:'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // Show Date Picker and Time Picker
                                          DateTime? selectedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (selectedDate != null) {
                                            TimeOfDay? selectedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (selectedTime != null) {
                                              // Combine Date and Time
                                              setState(() {
                                                bookingDateTime = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month,
                                                  selectedDate.day,
                                                  selectedTime.hour,
                                                  selectedTime.minute,
                                                );
                                              });
                                              // Do something with the selected date and time
                                            }
                                          }
                                        },
                                        child: bookingDateTime == null
                                            ? const Text('Select Date and Time')
                                            : Text(
                                                '${bookingDateTime!.day}/${bookingDateTime!.month}/${bookingDateTime!.year} ${bookingDateTime!.hour}:${bookingDateTime!.minute}',
                                              ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Hủy'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  !isPreBooking
                                      ? BookingController(context: context)
                                          .createBooking(
                                              distance: distance.toInt(),
                                              pickupLocation: pickLocation,
                                              dropoffLocation: dropLocation,
                                              userId: user?.userId ?? 0,
                                              currentLocation: firstPick)
                                      : BookingController(context: context)
                                          .createBookingAdvance(
                                              pickupLocation: pickLocation,
                                              dropoffLocation: dropLocation,
                                              distance: distance.toInt(),
                                              userId: user?.userId ?? 0,
                                              currentLocation: firstPick,
                                              pickupTime:
                                                  "${bookingDateTime?.toIso8601String()}Z");
                                  // Navigator.pop(context); // Close the modal
                                  // Proceed with vehicle confirmation logic
                                },
                                child: const Text('Xác Nhận'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
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
                              'Xóa',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          : const Text(
                              "Chọn điểm đến",
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

class ButtonBottom extends StatelessWidget {
  const ButtonBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
