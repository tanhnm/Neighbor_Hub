import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/booking_detail_model.dart';
import 'package:flutter_application_1/domains/freezed/registration_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/drivers_controller.dart';

class DriverListScreenNew extends ConsumerWidget {
  const DriverListScreenNew({super.key, required this.bookingDetail});
  final BookingDetailModel bookingDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the driverProvider
    final driverState = ref.watch(driversControllerProvider(bookingDetail.bookingId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Các Tài Xế'),
      ),
      body: driverState.when(
        data: (registrations) {

          if(registrations.isEmpty) return Center(child: Text('Empty'));

          return ListView.builder(
            itemCount: registrations.length,
            itemBuilder: (context, index) {
              RegistrationFormModel registration = registrations[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'),
                  ),
                  title: Text(registration.driver.username),
                  subtitle: Text(registration.driver.phone),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MessageScreen(
                    //       driver: driver,
                    //       booking: booking,
                    //       registrationId: registrationId,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()), // Show loading spinner
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger fetching of drivers when the button is pressed
          ref.read(driversControllerProvider(bookingDetail.bookingId).notifier).fetchDrivers(bookingDetail.bookingId);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
