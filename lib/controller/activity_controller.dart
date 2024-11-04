
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/api/app_repository.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/providers/user_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_controller.g.dart';

@Riverpod(keepAlive: true)
class ActivityController extends _$ActivityController {
  @override
  FutureOr<List<BookingDetailModel>> build() {

    final user = ref.read(userProvider);
    return getActivities(user.value!.userId);
  }

  Future<List<BookingDetailModel>> getActivities(int userId){
    final appRepository = ref.watch(appRepositoryProvider);
    final cancelToken = CancelToken();
    return appRepository.getBookingDetails(
      userId,
      cancelToken: cancelToken,
    );
  }
}