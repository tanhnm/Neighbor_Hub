import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/router.dart';
import 'package:flutter_application_1/common/routes.dart';
import 'package:flutter_application_1/controller/booking_service.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controller/activity_controller.dart';
import '../../providers/driver_notifier.dart';
import '../payment/qrcode_payment_screen.dart';

class ProfileScreenNew extends HookConsumerWidget {
  final BookingDetailModel bookingDetail;

  const ProfileScreenNew({
    super.key,
    required this.bookingDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the driver's decision state
    final isWaitingForDecision = ref.watch(driverDecisionProvider);
    final isDealAccepted = ref.watch(dealAcceptedProvider);
    final driverAmount = ref.watch(driverAmountProvider);
    final price = ref.watch(priceProvider);

    // Watch the FutureProvider for booking info

    // Simulate driver decision when the widget is built
    ref.read(driverDecisionProvider.notifier).simulateDriverDecision();

    final List<Map<String, dynamic>> comments = [
      {
        "username": "Viet Phuc",
        "rating": 5,
        "comment": "Great driver! Highly recommend."
      },
      {
        "username": "Ha Giang",
        "rating": 4,
        "comment": "Very polite and punctual."
      },
      {
        "username": "Minh Phu",
        "rating": 3,
        "comment": "Average experience, could improve."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin ${bookingDetail.registration!.driver!.username}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Image Section
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
              ),
              radius: 50,
            ),
            const SizedBox(height: 16),
            // Driver Info Section
            Text(
              bookingDetail.registration!.driver!.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              bookingDetail.registration!.driver!.phone,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              bookingDetail.registration!.driver!.email,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            // Ratings and Revenue Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bookingDetail.registration!.driver!.averageRating.toString(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Lương',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${convertNum(bookingDetail.registration!.driver!.revenue)} điểm',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Driver Comments Section
            const Text(
              'Bình Luận:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comment['username'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '⭐️' * comment['rating'], // Rating stars
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(comment['comment']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Add Deal Price Driver waiting for decision
            //todo: api/v1/booking/getDriverAmount?driverId=1&bookingId=33
            //todo: lỗi nên xóa

            // Consumer(builder: (context, ref, child) {
            //   final bookingInfoAsyncValue = ref.watch(amountControllerProvider(
            //       bookingDetail.registration!.driver!.driverId, bookingDetail.bookingId
            //   ));
            //
            //   return bookingInfoAsyncValue.when(
            //     data: (amount) {
            //       ref.read(driverAmountProvider.notifier).state = amount.amount;
            //       ref.read(priceProvider.notifier).state = amount.amount;
            //       // return Text('aaa');
            //       print(amount.amount);
            //       return amount.amount > 0
            //           ? Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Người chở ra giá ${convertNum(amount.amount)} điểm',
            //             style: const TextStyle(
            //                 color: Colors.red,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18),
            //           ),
            //         ],
            //       )
            //           : Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Text(
            //             'Đang đợi tài xế chấp nhận deal',
            //             style: TextStyle(
            //                 fontSize: 18, fontWeight: FontWeight.bold),
            //           ),
            //           LoadingAnimationWidget.waveDots(
            //               color: Colors.black, size: 20.0),
            //         ],
            //       );
            //     },
            //     loading: () => const Center(child: CircularProgressIndicator()),
            //     error: (error, stackTrace) => Text('Error: $error'),
            //   );
            // }),
            // const SizedBox(height: 10),
            // Action Buttons
            // Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: const Size(double.infinity, 50),
            //         backgroundColor: driverAmount > 0.0
            //             ? const Color(0xFFFDC6D6)
            //             : Colors.grey),
            //     onPressed:
            //          () async {
            //       // Handle action for accepted deal
            //       //todo: add driver to deal
            //       // Future<Map<String, dynamic>> addDriver() async {
            //       //   return BookingController(context: context).addDriver(
            //       //       registrationId: bookingDetail.registration!.registrationId,
            //       //       bookingId: bookingDetail.bookingId);
            //       // }
            //      //  final bookingService = ref.read(bookingServiceProvider);
            //      // final response =  await bookingService.addDriver(bookingDetail.registration!.registrationId,  bookingDetail.bookingId);
            //      //  if(true){
            //      //    if(context.mounted){
            //      //      context.goNamed(Routes.activity);
            //      //      ref.refresh(activityControllerProvider);
            //      //    }
            //      //  }
            //       // Map<String, dynamic> data = await addDriver();
            //       // String imgUrlPayment = '';
            //       // // Handle action for accepted deal
            //       // Future<String> simulateDriverDecision() async {
            //       //   return BookingController(context: context)
            //       //       .createQrCodePayment(bookingDetail.bookingId);
            //       // }
            //       //
            //       // imgUrlPayment = await simulateDriverDecision();
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //     builder: (context) => QRCodeScanPage(
            //       //       imgUrl: imgUrlPayment,
            //       //     ),
            //       //   ), // SelectRatingScreen
            //       // );
            //     }
            //         , // Disable button if deal is not accepted
            //     child: const Text('Chốt Deal Với Tài Xế Này',
            //         style: TextStyle(fontSize: 18, color: Colors.black)),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  print(bookingDetail.registration!.registrationId);
                  print(bookingDetail.user.userId);
                  print(bookingDetail.bookingId);
                  final bookingService = ref.read(bookingServiceProvider);
                  await bookingService.addDriverRequest(bookingDetail.user.userId,
                      bookingDetail.registration!.registrationId, bookingDetail.bookingId).then((value) {
                    if(value.bookingId == bookingDetail.bookingId){
                      context.goNamed(Routes.activity);
                      ref.invalidate(activityControllerProvider);
                    }
                  });

                },
                child: Text('Chọn tài xế'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
