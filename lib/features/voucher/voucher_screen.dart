import 'package:flutter_application_1/controller/voucher_controller.dart';
import 'package:flutter_application_1/domains/freezed/booking_voucher_model.dart';
import 'package:flutter_application_1/features/booking_car/map_screen_new.dart';
import 'package:flutter_application_1/utils/extensions/string_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class VoucherScreen extends HookConsumerWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucherController = ref.watch(voucherControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vouchers"),
      ),
      body: voucherController.when(
        data: (vouchers) {
          return ListView.builder(
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              VoucherModel voucher = vouchers[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    voucher.description,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    voucher.expiryDate.convertToVietnameseTime(),
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue[50],
                    ),
                    child: Text(
                      voucher.code,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  tileColor: Colors.grey[100], // Background color for the ListTile
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              );
            },
          );
        },
        loading: () => Center(
          child: LoadingAnimationWidget.waveDots(
            color: Colors.black,
            size: 40,
          ),
        ),
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
      ),
    );
  }
}

