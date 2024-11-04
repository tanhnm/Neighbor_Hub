import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/driver/message_screen_driver_new.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../domains/freezed/booking_model.dart';
import '../../providers/user_provider.dart';
import '../../services/driver_service/driver_service.dart';
import '../../services/driver_service/registration_service.dart';
import '../temp_screen/navbar_screen.dart';

class UserListScreenNew extends HookConsumerWidget {
  const UserListScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final driverService = DriverService();

    // State variables using hooks
    final user = useState<int?>(null);
    final userBox = useState<Box?>(null);
    final userIdFuture = useState<Future<int>?>(null);

    final registrationFormId = useState<int?>(null);
    final registrationStatus = useState<int?>(null);
    final vehicleType = useState<String?>(null);


    final userAsyncValue = ref.watch(userProvider);

    useEffect(() {
      Future<void> _loadRegistrationData(int userId) async {
        try {
          final forms = await RegistrationService().getAllRegistrationForms(userId);
          if (forms.isNotEmpty) {
            registrationFormId.value = forms[0]['registrationId'] as int;
            registrationStatus.value = forms[0]['status'] as int;
            vehicleType.value = forms[0]['vehicleType'] as String;
          } else {
            Fluttertoast.showToast(
              msg: 'No registration forms found.',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
            );
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Error opening Hive box',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        }
      }

      // Load registration data when the user is available
      userAsyncValue.whenData((user) {
        if (user != null) {
          _loadRegistrationData(user.userId);
        }
      });

      return null; // No clean-up needed
    }, [userAsyncValue]); // Re-run when userAsyncValue changes





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
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No user found.'));
          }

          if (registrationStatus.value == 0) {
            return const Center(
              child: Text("Hãy Bật Chế Độ Đang Rảnh Để Xem"),
            );
          }

          return FutureBuilder<List<BookingModel>>(
            future: driverService.getAllBookings(user.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: Colors.black, size: 40,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No bookings found.'));
              } else {
                // Remove duplicate bookings based on bookingId
                final seenBookingIds = <int>{};
                final bookings = snapshot.data!.where((booking) {
                  final bookingId = booking.bookingDetail.bookingId;
                  if (seenBookingIds.contains(bookingId)) {
                    return false; // Duplicate found
                  } else {
                    seenBookingIds.add(bookingId); // Mark as seen
                    return true; // Keep the booking
                  }
                }).toList();
                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageScreenDriverNew(
                                // user: {
                                //   'userId': booking.bookingDetail.user.userId,
                                //   'username': booking.bookingDetail.user.username,
                                //   'phone': booking.bookingDetail.user.phone,
                                //   'email': booking.bookingDetail.user.email,
                                //   'location': booking.bookingDetail.pickupLocation,
                                //   'destination': booking.bookingDetail.dropoffLocation,
                                // },
                                user,
                                 booking,
                                 user.userId,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Booking ID: ${booking.bookingDetail.bookingId}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Điểm đón: ${booking.bookingDetail.pickupLocation}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Điểm đến: ${booking.bookingDetail.dropoffLocation}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Ngày: ${booking.bookingDetail.pickupTime.convertToVietnameseTime()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Loại xe: ${vehicleType.value}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                UserCard(
                                  name: booking.bookingDetail.user.username,
                                  phone: booking.bookingDetail.user.phone,
                                  kilometers: '${booking.bookingDetail.distance} km',
                                  price: "${booking.amount} VNĐ",
                                  image: 'https://via.placeholder.com/50',
                                  userId: booking.bookingDetail.user.userId,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
        loading: () => Center(
          child: LoadingAnimationWidget.waveDots(
            color: Colors.black, size: 40,
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                    Text(name.truncateWithWords(3),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
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