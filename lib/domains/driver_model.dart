class Driver {
  final int driverId;
  final String username;
  final String phone;
  final String email;
  final double averageRating;
  final double revenue;

  Driver({
    required this.driverId,
    required this.username,
    required this.phone,
    required this.email,
    required this.averageRating,
    required this.revenue,
  });

  // Factory method to parse the JSON response
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      averageRating: json['averageRating'].toDouble(),
      revenue: json['revenue'].toDouble(),
    );
  }
}
