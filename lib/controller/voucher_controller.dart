
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/api/app_repository.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/providers/user_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domains/freezed/booking_voucher_model.dart';

part 'voucher_controller.g.dart';

@Riverpod(keepAlive: true)
class VoucherController extends _$VoucherController {
  @override
  FutureOr<List<VoucherModel>> build() {

    final user = ref.read(userProvider);
    return getAllVouchers(user.value!.userId);
  }

  Future<List<VoucherModel>> getAllVouchers(int userId){
    final appRepository = ref.watch(appRepositoryProvider);
    final cancelToken = CancelToken();
    return appRepository.getAllVouchers(
      cancelToken: cancelToken,
    );
  }
}