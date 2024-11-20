import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/controller/activity_controller.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/features/booking_car/map_screen_new.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/routes.dart';
import '../../controller/booking_service.dart';
import '../auth/profile_screen_new.dart';
import 'package:collection/collection.dart';

class ActivityScreenNew extends HookConsumerWidget {
  const ActivityScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hoạt động"),
          actions: [
            IconButton(onPressed: (){
              ref.invalidate(activityControllerProvider);
            }, icon: const Icon(FontAwesomeIcons.arrowsRotate))
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final activities = ref.watch(activityControllerProvider);

          return activities.when(
              data: (bookings) {
                List<BookingDetailModel> bookingList = List.from(bookings)
                  ..sort((a, b) => b.bookingId.compareTo(a.bookingId));
                return bookings.isEmpty
                    ? const Center(
                        child: Text(
                        'Bạn chưa đặt xe nào cả!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: bookingList.length,
                        itemBuilder: (context, index) {
                          BookingDetailModel bookingDetail = bookingList[index];
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
                                    "Tình Trạng: ${bookingDetail.status.convertToVietnamese()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: bookingDetail.status == "completed"
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Người chở: ${bookingDetail.registration?.driver!.username ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Giá Thỏa Thuận: ${convertNum(bookingDetail.amount)} điểm",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  bookingDetail.status == "BookingCompleted"
                                      ? Center(child: Text('Đã hoàn thành', style: TextStyle(fontSize: 18, color: Colors.blue),))
                                      : ElevatedButton(
                                          onPressed: isPastPickupTime
                                              ? null
                                              : () async {
                                                  if (bookingDetail
                                                          .registration ==
                                                      null) {
                                                    context.pushNamed(
                                                        Routes.driverList,
                                                        extra: bookingDetail);
                                                  } else {
                                                    // Handle view booking details logic here
                                                    //todo:
                                                    if(bookingDetail.status !=
                                                        "DriverEnRoute")  {
                                                    context.pushNamed(
                                                        Routes.profileDriver,
                                                        extra: bookingDetail);
                                                  } else {
                                                    //note: call api complete booking
                                                      print('complete booking');
                                                      final bookingService = ref.read(bookingServiceProvider);
                                                      await bookingService.putBookingComplete(
                                                          bookingDetail.registration!.registrationId, bookingDetail.bookingId).then((value) {
                                                        if(value == 200){
                                                          Fluttertoast.showToast(
                                                            msg: 'Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!',
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.CENTER,
                                                            timeInSecForIosWeb: 1,
                                                            fontSize: 16.0,
                                                          );
                                                          ref.invalidate(activityControllerProvider);
                                                        }
                                                      });
                                                  }
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
                                              : bookingDetail.registration ==
                                                      null
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                          const Text(
                                                              'Đang Tìm Tài Xế'),
                                                          const SizedBox(
                                                              width: 8),
                                                          LoadingAnimationWidget
                                                              .waveDots(
                                                                  color: Colors
                                                                      .black,
                                                                  size: 16),
                                                        ])
                                                  : bookingDetail.status ==
                                                          "DriverEnRoute"
                                                      ? const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          children: [
                                                              Text(
                                                                  'Tài Xế Đang Trên Đường')
                                                            ])
                                                      : const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                              Text(
                                                                  'Deal Với Tài Xế Ngay')
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
            Text("Driver: ${bookingDetail.registration!.driver!.username}"),
            Text("Amount: ${convertNum(bookingDetail.amount)}"),
          ],
        ),
      ),
    );
  }
}
