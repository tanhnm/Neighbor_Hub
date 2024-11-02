// For jsonEncode
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class VoucherService {
  final BuildContext context;
  VoucherService({required this.context});
  final String _baseUrl =
      'https://gh-neighborhub-569199407036.asia-southeast1.run.app/api/v1/';

  // Method to get fare based on travel time
  Future<void> getVoucher() async {
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}voucher/viewAllVoucher'));
      if (response.statusCode == 200) {
        var box = Hive.box('authBox');
        // Store the token in Hive
        await box.put('vouchers', response.body);
        // You can use the response here to show the fare details
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: Text('viewAllVoucher: ${response.body}'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else {
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          title: Text(
              'Failed to viewAllVoucher. Status code: ${response.statusCode}'),
        );
      }
    } catch (e) {
      toastification.show(
        context: context,
        style: ToastificationStyle.flat,
        title: Text('Error occurred: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      rethrow;
    }
  }
}
