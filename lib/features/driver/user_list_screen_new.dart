import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/router.dart';
import 'package:flutter_application_1/common/routes.dart';
import 'package:flutter_application_1/features/driver/message_screen_driver_new.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../domains/freezed/booking_model.dart';
import '../../providers/user_provider.dart';
import '../../services/driver_service/driver_service.dart';
import '../../services/driver_service/driver_service_new.dart';
import '../../services/driver_service/registration_service.dart';
import '../temp_screen/navbar_screen.dart';

class UserListScreenNew extends HookConsumerWidget {
  const UserListScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userAsync = ref.watch(userModelProvider);
          final driverAsyncValue = ref.watch(getAllRegistrationFormsByIdProvider);
          final bookingByDriverProvider = ref.watch(getAllBookingsByDriverIdProvider);
          return driverAsyncValue.when(
            loading: () =>  LoadingAnimationWidget.waveDots(
                color: Colors.blue, size: 40),
            error: (err, stack) => Text('Error::: $err'),
            data: (data) {
              int regStatus = data[0].status;
              String vehicleType = data[0].vehicleType;
              return regStatus == 0
                  ? Center(
                  child: regStatus == 0
                      ? const Text("Hãy Bật Chế Độ Đang Rảnh Để Xem")
                      : LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 40))
                  : bookingByDriverProvider.when(
                  data: (bookingList){
                    if(bookingList.isEmpty)  return const Center(child: Text('No bookings found.'));
                    final seenBookingIds = <int>{};
                    final bookings = bookingList.where((booking) {
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
                                context.pushNamed(Routes.messageDriver, extra: booking);
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 4),
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
                                          maxLines: 1),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Điểm đến ${booking.bookingDetail.dropoffLocation}',
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
                                        'Ngày: ${booking.bookingDetail.pickupTime?.convertToVietnameseTime()}',
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
                                        'Loại xe: $vehicleType',
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
                                        kilometers:
                                        '${booking.bookingDetail.distance} km',
                                        price: "${booking.amount} VNĐ",
                                        image: 'https://via.placeholder.com/50',
                                        userId: booking.bookingDetail.user.userId,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  },
                loading: () =>  LoadingAnimationWidget.waveDots(
                    color: Colors.black, size: 40),
                error: (err, stack) => Text('Error: $err'),

              );
            },
          );
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
