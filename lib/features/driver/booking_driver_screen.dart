import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/drivers_controller.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/features/driver/user_list_screen_new.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/routes.dart';

class BookingDriverScreen extends HookConsumerWidget {
  const BookingDriverScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Driver'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final bookingDriver = ref.watch(bookingDriverControllerProvider);
        return bookingDriver.when(data: (data){
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                final BookingDetailModel bookingDetail = data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        // context.pushNamed(Routes.messageDriver, extra: bookingDetail.booking);
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
                                'Booking ID: ${bookingDetail.bookingId}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  'Điểm đón: ${bookingDetail.pickupLocation}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              const SizedBox(height: 8),
                              Text(
                                'Điểm đến ${bookingDetail.dropoffLocation}',
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
                                'Ngày: ${bookingDetail.pickupTime?.convertToVietnameseTime()}',
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
                                'Loại xe: ${bookingDetail.registration!.vehicleType!}',
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
                                name: bookingDetail.user.username,
                                phone: bookingDetail.user.phone,
                                kilometers:
                                '${bookingDetail.distance} km',
                                price: "${bookingDetail.amount} điểm",
                                image: 'https://via.placeholder.com/50',
                                userId: bookingDetail.user.userId,
                              ),
                            ],
                          ),
                        ),
                      )),
                );
          });
        },
          error: (err, stack) => Text('Error $err'),
          loading: () => Text('loading'),
        );
      }),
    );
  }
}
