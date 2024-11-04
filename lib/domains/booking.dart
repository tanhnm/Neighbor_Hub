// class Booking {
//   final int bookingId;
//   final String pickupLocation;
//   final String dropoffLocation;
//   final String pickupTime;
//   final double distance; // Change this to double
//   final String userName;
//
//   Booking({
//     required this.bookingId,
//     required this.pickupLocation,
//     required this.dropoffLocation,
//     required this.pickupTime,
//     required this.distance, // Keep this as double
//     required this.userName,
//   });
//
//   // Factory method to create a Booking instance from JSON
//   factory Booking.fromJson(Map<String, dynamic> json) {
//     return Booking(
//       bookingId: json['bookingId'],
//       pickupLocation: json['pickupLocation'],
//       dropoffLocation: json['dropoffLocation'],
//       pickupTime: json['pickupTime'],
//       distance: json['distance'].toDouble(), // Ensure this is parsed as double
//       userName: json['userName'],
//     );
//   }
// }
//todo: remove