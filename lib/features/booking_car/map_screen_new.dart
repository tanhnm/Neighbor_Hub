import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

import '../../common/routes.dart';
import '../../controller/activity_controller.dart';
import '../../controller/booking_service.dart';
import '../../data/api/api.dart';
import '../../domains/trip.dart';
import '../../domains/freezed/user_model.dart';
import '../../services/coordinate_service/coordinate_service.dart';
import '../../services/fare_service/booking_controller.dart';
import '../../services/fare_service/fare_controller.dart';
import '../../view/button_bottom.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapScreenNew extends HookConsumerWidget {
  const MapScreenNew( {super.key, required this.initialLatitude, required this.initialLongitude,});

  final double initialLatitude;
  final double initialLongitude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final points = useState<List<LatLng>>([]);
    final listOfPoint = useState([]);
    final secondPick = useState<String>('');
    final firstPickDone = useState<bool>(false);
    final isPreBooking = useState<bool>(false);
    final farePrice = useState<double>(0.0);
    final distance = useState<double>(0.0);
    final duration = useState<double>(0.0);
    final isLoading = useState<bool>(false);
    final bookingDateTime = useState<DateTime?>(DateTime.now());
    final price = useState(0);
    final mapController = useMemoized(() => MapController());

    final currentCenter =
        useState<LatLng>(LatLng(initialLatitude, initialLongitude));
    final suggestions = useState<List<Map<String, dynamic>>>([]);
    final vehicles = useState<List<Map<String, String>>>([]);
    final dropLocation = useState<String>('');
    final pickLocation = useState<String>('');

    final selectedVehicle = useState<String>('');

    final firstPick = useState<String>(
        "${currentCenter.value.longitude}, ${currentCenter.value.latitude}");
    final selectedMarkers = useState<List<Marker>>([
      Marker(
        rotate: true,
        point: currentCenter.value,
        width: 30,
        height: 30,
        child: const Icon(
          FontAwesomeIcons.locationCrosshairs,
          size: 30,
          color: Colors.blue,
        ),
      ),
    ]);

    final searchController = useTextEditingController();
    final user = ref.watch(userProvider);

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

          mapController.move(newLocation, 15.0);
          currentCenter.value = newLocation;
          selectedMarkers.value.add(
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
        } else {
          if(context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Lỗi gợi ý vị trí')),
            );
          }
        }
      } else {
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lỗi gợi ý vị trí')),
          );
        }
      }
    }

    Future<void> getSuggestions(String query) async {
      double delta = 0.1; // Size of the bounding box
      double southWestLat = currentCenter.value.latitude - delta;
      double southWestLon = currentCenter.value.longitude - delta;
      double northEastLat = currentCenter.value.latitude + delta;
      double northEastLon = currentCenter.value.longitude + delta;

      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&bounded=1&viewbox=$southWestLon,$northEastLat,$northEastLon,$southWestLat');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;

        suggestions.value = data.map((item) {
          double suggestionLat = double.parse(item['lat']);
          double suggestionLon = double.parse(item['lon']);
          double distance = Geolocator.distanceBetween(
            currentCenter.value.latitude,
            currentCenter.value.longitude,
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
      } else {
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi gợi ý vị trí')),
        );
        }
      }
    }

    void onSearchChanged(String value) {
      if (value.isNotEmpty) {
        getSuggestions(value); // Fetch suggestions as the user types
      } else {
        suggestions.value = []; // Clear suggestions if search field is empty
      }
    }

    void onSuggestionTapped(Map<String, dynamic> suggestion) {
      searchController.text = suggestion['display_name'];
      searchLocation(suggestion['display_name']);
      suggestions.value = []; // Clear suggestions after selection
    }

    void pickLocation0() async {
      firstPickDone.value = true;
      if (firstPickDone.value) {
        secondPick.value =
            "${currentCenter.value.longitude}, ${currentCenter.value.latitude}";
      }

      dropLocation.value = await getPlaceName(
          currentCenter.value.latitude.toString(),
          currentCenter.value.longitude.toString());

      if (selectedMarkers.value.length < 2) {
        // Add new marker
        selectedMarkers.value.add(
          Marker(
            rotate: true,
            point: currentCenter.value,
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
        getCoordinates(
            context: context,
            firstPick: firstPick.value,
            secondPick: secondPick.value,
            pickLocation: pickLocation,
            isLoading: isLoading,
            listOfPoint: listOfPoint,
            distance: distance,
            duration: duration,
            points: points,
            vehicles: vehicles);
      } else {
        // If 2 markers already exist, clear them and allow new picks
        selectedMarkers.value.removeAt(1);
        points.value = [];
        firstPickDone.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn vị trí trên bản đồ'),
      ),
      body: GestureDetector(
          onTap: () {
            selectedVehicle.value = '';
          },
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: currentCenter.value,
                  initialZoom: 15.0,
                  onPositionChanged: (camera, hasGesture) {
                    selectedVehicle.value = '';
                    currentCenter.value = camera.center;
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              firstPickDone.value
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
                          controller: searchController,
                          onChanged: onSearchChanged,
                          decoration: InputDecoration(
                            hintText: 'Tìm địa điểm gần đây...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                searchLocation(searchController.text);
                              },
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
              // Suggestions List
              if (suggestions.value.isNotEmpty)
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
                    itemCount: suggestions.value.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestions.value[index];
                      return ListTile(
                        title: Text(suggestion['display_name']),
                        subtitle: Text(
                            '${suggestion['distance'].toStringAsFixed(2)} meters away'),
                        onTap: () {
                          onSuggestionTapped(suggestion);
                        },
                      );
                    },
                  ),
                ),
              firstPickDone.value
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
                              isLoading.value
                                  ? Center(
                                      child: LoadingAnimationWidget.waveDots(
                                          color: Colors.black, size: 30))
                                  : Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: vehicles.value.length,
                                        itemBuilder: (context, index) {
                                          final vehicle = vehicles.value[index];
                                          bool isSelected = vehicle['type'] ==
                                              selectedVehicle;

                                          return GestureDetector(
                                            onTap: () {
                                              selectedVehicle.value =
                                                  vehicle['type']!;
                                              // price.value = int.parse(vehicle['price']!);
                                              price.value = double.parse(vehicle['price']!).toInt();
                                              print(price.value);
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
                                                    Text(vehicle['distance']!
                                                        .convertToKilometers()),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        vehicle['price']!
                                                            .formatPriceFromString(),
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
          mapController.move(LatLng(initialLatitude, initialLongitude), 15.0);
        },
        child: const Icon(Icons.my_location),
      ),
      bottomNavigationBar: selectedVehicle.value.isNotEmpty
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
                                                bookingDateTime.value =
                                                    DateTime(
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
                                                '${bookingDateTime.value!.day}/${bookingDateTime.value!.month}/${bookingDateTime.value!.year} ${bookingDateTime.value!.hour}:${bookingDateTime.value!.minute}',
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
                                  final bookingService = ref.read(bookingServiceProvider);
                                  final response = !isPreBooking ? await bookingService.createBooking(
                                       distance: distance.value.toInt(),
                                       pickupLocation:
                                       pickLocation.value,
                                       dropoffLocation:
                                       dropLocation.value,
                                       userId: user.value?.userId ?? 0,
                                       price: price.value,
                                       currentLocation: firstPick.value
                                   ): await bookingService.createAdvanceBooking(
                                      pickupLocation:
                                      pickLocation.value,
                                      dropoffLocation:
                                      dropLocation.value,
                                      distance: distance.value.toInt(),
                                      userId: user.value?.userId ?? 0,
                                      currentLocation: firstPick.value,
                                      price: price.value,
                                      pickupTime:
                                      "${bookingDateTime.value?.toIso8601String()}Z"
                                  );

                                  if (response.response.statusCode == 200 || response.response.statusCode == 201) {
                                    var box = Hive.box('locationBox');
                                    await box.put('currentLocation', firstPick.value);
                                    if(context.mounted){
                                      Navigator.pop(context);
                                      ref.invalidate(activityControllerProvider);
                                      context.pushNamed(Routes.activity);

                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Lỗi',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0,
                                    );
                                  }
                                  // !isPreBooking
                                  //     ? BookingController(context: context)
                                  //         .createBooking(
                                  //             distance: distance.value.toInt(),
                                  //             pickupLocation:
                                  //                 pickLocation.value,
                                  //             dropoffLocation:
                                  //                 dropLocation.value,
                                  //             userId: user.value?.userId ?? 0,
                                  //             currentLocation: firstPick.value)
                                  //     : BookingController(context: context)
                                  //         .createBookingAdvance(
                                  //             pickupLocation:
                                  //                 pickLocation.value,
                                  //             dropoffLocation:
                                  //                 dropLocation.value,
                                  //             distance: distance.value.toInt(),
                                  //             userId: user.value?.userId ?? 0,
                                  //             currentLocation: firstPick.value,
                                  //             pickupTime:
                                  //                 "${bookingDateTime.value?.toIso8601String()}Z");

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
                  "Xác nhận",
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
                      onPressed: pickLocation0,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Same as Confirm button
                        padding: const EdgeInsets.symmetric(
                            vertical: 15), // Ensure vertical padding
                      ),
                      child: selectedMarkers.value.length == 2
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
