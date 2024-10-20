import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart' as UserModel;
import 'package:flutter_application_1/services/driver_service/driver_service.dart';
import 'package:flutter_application_1/screens/Driver/message_screen_driver.dart';
import 'package:hive/hive.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final DriverService driverService = DriverService();
  UserModel.User? user;
  Box<UserModel.User>? userBox;
  Future<int>? userIdFuture;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = await Hive.openBox<UserModel.User>('users');
      setState(() {
        userIdFuture = _loadUser();
      });
    } catch (e) {
      print('Error opening Hive box: $e');
    }
  }

  Future<int> _loadUser() async {
    try {
      user = userBox?.get('user');
      if (user == null) {
        throw Exception('No user found in the Hive box.');
      }
      print(user!.userId);
      return user!.userId;
    } catch (e) {
      print('Error loading user: $e');
      throw e;
    }
  }

  @override
  void dispose() {
    userBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: userIdFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Booking>>(
              future: userIdFuture!
                  .then((userId) => driverService.getAllBookings(userId)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                        child: UserCard(
                          name: booking.booking.user.username,
                          phone: booking.booking.user.phone,
                          kilometers: '${booking.booking.distance} km',
                          price: "\$${booking.amount}",
                          image: 'https://via.placeholder.com/50',
                          userId: booking.booking.user.userId,
                        ),
                      );
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
    Key? key,
    required this.name,
    required this.phone,
    required this.kilometers,
    required this.price,
    required this.image,
    required this.userId,
  }) : super(key: key);

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
