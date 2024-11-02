String convertToKilometers(String distance) {
  // Extract the numeric part from the string (ignoring the " meters" part)
  double meters = double.parse(distance.replaceAll(RegExp(r'[^0-9.]'), ''));

  // Convert meters to kilometers
  double kilometers = meters / 1000;

  // Return the result as a string with " km" appended
  return '${kilometers.toStringAsFixed(2)} km';
}
