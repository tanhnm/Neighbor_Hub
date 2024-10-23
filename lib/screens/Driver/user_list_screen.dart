import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart' as UserModel;
import 'package:flutter_application_1/screens/navbar_screen.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_application_1/screens/Driver/message_screen_driver.dart';
import 'package:flutter_application_1/services/driver_service/registration_service.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final DriverService driverService = DriverService();
  int? user;
  Box? userBox;
  Future<int>? userIdFuture;

  int? registrationFormId;
  int? registrationStatus;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = await Hive.openBox('authBox');
      setState(() {
        userIdFuture = _loadUser();
        userIdFuture!.then((value) => user = value);
      });
      // Call to get all registration forms
      final forms = await RegistrationService().getAllRegistrationForms(user!);
      if (forms.isNotEmpty) {
        // Assign the first registrationId to registrationFormId
        registrationFormId = forms[0]['registrationId'] as int;
        setState(() {
          registrationStatus = forms[0]['status'] as int;
        });
        print('Registration Form ID: $registrationStatus'); // Debugging line
      } else {
        print('No registration forms found.');
      }
    } catch (e) {
      print('Error opening Hive box: $e');
    }
  }

  Future<int> _loadUser() async {
    try {
      user = userBox?.get('driverId');
      if (user == null) {
        throw Exception('No user found in the Hive box.');
      }
      print(user);
      return user!;
    } catch (e) {
      print('Error loading user: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: registrationStatus == 0
          ? Center(
              child: registrationStatus == 0
                  ? const Text("Hãy Bật Chế Độ Đang Rảnh Để Xem")
                  : LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 40))
          : FutureBuilder<List<Booking>>(
              future: userIdFuture
                  ?.then((userId) => driverService.getAllBookings(user!)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.waveDots(
                          color: Colors.black, size: 40));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No bookings found.'));
                } else {
                  final bookings = snapshot.data!;
                  return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageScreenDriver(
                                  user: {
                                    'userId': booking.booking.user.userId,
                                    'username': booking.booking.user.username,
                                    'phone': booking.booking.user.phone,
                                    'email': booking.booking.user.email,
                                    'location': booking.booking.pickupLocation,
                                    'destination':
                                        booking.booking.dropoffLocation,
                                  },
                                  booking: booking,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                'Booking ID: ${booking.booking.bookingId}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              UserCard(
                                name: booking.booking.user.username,
                                phone: booking.booking.user.phone,
                                kilometers: '${booking.booking.distance} km',
                                price: "\$${booking.amount}",
                                image: 'https://via.placeholder.com/50',
                                userId: booking.booking.user.userId,
                              ),
                            ],
                          ));
                    },
                  );
                }
              },
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String phone;
  final String kilometers;
  final String price;
  final String image;
  final int userId;

  const UserCard({
    super.key,
    required this.name,
    required this.phone,
    required this.kilometers,
    required this.price,
    required this.image,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 25,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(phone),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(kilometers, style: const TextStyle(color: Colors.grey)),
                Text(price, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
