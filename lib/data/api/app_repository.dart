import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/restaurants.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/dio_provider.dart';

part 'app_repository.g.dart';

class AppRepository {
  AppRepository({required this.client});

  final Dio client;

  Future<List<BookingDetailModel>> getBookingDetails( int userid, {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: kBaseUrl,
      path: 'api/v1/booking/getBookingByUserId/$userid',
    ).toString();

    final response = await client.get(url, cancelToken: cancelToken);
    final List list = response.data;
    print(list);
    return list.map((e) => BookingDetailModel.fromJson(e)).toList();
  }

}

@Riverpod(keepAlive: true)
AppRepository appRepository(Ref ref) => AppRepository(
  client: ref.watch(dioProvider),
);