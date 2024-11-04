import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/controller/activity_controller.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/routes.dart';
import '../auth/profile_screen_new.dart';

class ActivityScreenNew extends HookConsumerWidget {
  const ActivityScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Activity"),
        ),
        body: Consumer(builder: (context, ref, child) {
          final activities = ref.watch(activityControllerProvider);

          return activities.when(
              data: (bookings) {
                return bookings.isEmpty
                    ? const Center(
                        child: Text(
                        'Bạn chưa đặt xe nào cả!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          BookingDetailModel bookingDetail = bookings[index];
                          var isPastPickupTime = DateTime.parse(
                                  bookingDetail.pickupTime.toString())
                              .isBefore(DateTime.now()
                                  .subtract(const Duration(days: 3)));

                          return Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BookingId: ${bookingDetail.bookingId}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Điểm đón: ${bookingDetail.pickupLocation}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Điểm đi: ${bookingDetail.dropoffLocation}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    bookingDetail.pickupTime,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tình Trạng: ${bookingDetail.status}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: bookingDetail.status == "completed"
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Người chở: ${bookingDetail.registration?.driver.username ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Giá Thỏa Thuận: ${convertNum(bookingDetail.amount)} VNĐ",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: isPastPickupTime
                                        ? null
                                        : () {
                                            if (bookingDetail.registration
                                                    ?.driver.username ==
                                                'N/A') {
                                              context.pushNamed(
                                                  Routes.driverList,
                                                  extra: bookingDetail);
                                            } else {
                                              // Handle view booking details logic here

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileScreenNew(
                                                    driver: bookingDetail
                                                        .registration!.driver,
                                                    registrationFormId:
                                                        bookingDetail
                                                            .registration
                                                            !.registrationId,
                                                    booking:
                                                        bookingDetail.toJson(),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                    child: isPastPickupTime
                                        ? const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                Text(
                                                    'Đã quá thời gian để tìm tài xế!'),
                                              ])
                                        : bookingDetail.registration?.driver
                                                    .username ==
                                                'N/A'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    const Text(
                                                        'Đang Tìm Tài Xế'),
                                                    const SizedBox(width: 8),
                                                    LoadingAnimationWidget
                                                        .waveDots(
                                                            color: Colors.black,
                                                            size: 16),
                                                  ])
                                            : const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    Text('Deal Với Tài Xế Ngay')
                                                  ]),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
              error: (err, stack) => Text('Error $err'),
              loading: () => Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 50)));
        }));
  }
}

class BookingDetailsScreenNew extends StatelessWidget {
  final BookingDetailModel bookingDetail;

  const BookingDetailsScreenNew({super.key, required this.bookingDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pickup Location: ${bookingDetail.pickupLocation}"),
            Text("Dropoff Location: ${bookingDetail.dropoffLocation}"),
            Text("Status: ${bookingDetail.status}"),
            Text("Driver: ${bookingDetail.registration!.driver.username}"),
            Text("Amount: ${convertNum(bookingDetail.amount)}"),
          ],
        ),
      ),
    );
  }
}
