import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/services/fare_service/booking_controller.dart';
import '../../providers/drivers_controller.dart';
import 'message_screen.dart';

class DriverListScreenNew extends ConsumerWidget {
  const DriverListScreenNew({Key? key, required this.booking}) : super(key: key);
  final Map<String, dynamic> booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the driverProvider
    final driverState = ref.watch(driverProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Các Tài Xế'),
      ),
      body: driverState.when(
        data: (state) {
          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.drivers.isEmpty) {
            return const Center(child: Text('No drivers found'));
          }

          // Display the list of drivers
          return ListView.builder(
            itemCount: state.drivers.length,
            itemBuilder: (context, index) {
              final driver = state.drivers[index];
              final registrationId = state.registrationDrivers[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'),
                  ),
                  title: Text(driver['username']),
                  subtitle: Text(driver['phone']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(
                          driver: driver,
                          booking: booking,
                          registrationId: registrationId,
                        ),
                      ),
                    );
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
          ref.read(driverProvider.notifier).fetchDrivers(booking);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
