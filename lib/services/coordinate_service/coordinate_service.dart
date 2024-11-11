import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart'; // For LatLng
import 'package:flutter/material.dart';

import '../../data/api/api.dart';
import '../../domains/trip.dart';
import '../fare_service/fare_controller.dart'; // For context


// A service function to get coordinates and route data
Future<void> getCoordinates({
  required BuildContext context,
  required String firstPick,
  required String secondPick,
  required ValueNotifier<String> pickLocation,
  required ValueNotifier<bool> isLoading,
  required ValueNotifier<List<dynamic>> listOfPoint,
  required ValueNotifier<double> distance,
  required ValueNotifier<double> duration,
  required ValueNotifier<List<LatLng>> points,
  required ValueNotifier<List<Map<String, String>>> vehicles,
}) async {
  List<String> placeName = firstPick.split(',');
  pickLocation.value = await getPlaceName(placeName[1], placeName[0]);

  try {
    isLoading.value = true;
    var response = await http.get(getRouteUrl(firstPick, secondPick));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      listOfPoint.value = data['features'][0]['geometry']['coordinates'];
      distance.value = data['features'][0]['properties']['segments'][0]['distance'];
      duration.value = data['features'][0]['properties']['segments'][0]['duration'];

      points.value = listOfPoint.value
          .map((e) => LatLng(e[1].toDouble(), e[0].toDouble())) // Reverse them back for the map
          .toList();

      // Fetch fare details based on distance and duration
      // List<Trip> trips = await FareController(context: context)
      //     .getFare(distance: distance.value, travelTime: duration.value);
    //:note temp
      List<Trip> trips = [
        Trip(distance: 1000, travelTimeSeconds: 1000, tripCost: 10000, vehicleType: "Bike")
      ];

      // Populate the vehicles list with trip details
      for (var trip in trips) {
        vehicles.value.add({
          'type': trip.vehicleType,
          'distance': distance.value.toString(),
          'duration': duration.value.toString(),
          'price': trip.tripCost.toString(),
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Error response: ${response.body}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error: $e',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  } finally {
    isLoading.value = false;
  }
}

