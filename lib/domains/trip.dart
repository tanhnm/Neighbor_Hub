class Trip {
  final int distance;
  final int travelTimeSeconds;
  final double tripCost;
  final String vehicleType;

  Trip({
    required this.distance,
    required this.travelTimeSeconds,
    required this.tripCost,
    required this.vehicleType,
  });

  // Factory method to create a Trip from JSON
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      distance: json['distance'] is String
          ? int.tryParse(json['distance']) ?? 0
          : json['distance']?.toInt() ?? 0,
      travelTimeSeconds: json['travelTimeSeconds'] ?? 0,
      tripCost: json['tripCost'],
      vehicleType: json['vehicleType'] ?? '',
    );
  }
}
