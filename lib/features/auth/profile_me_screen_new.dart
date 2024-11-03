import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/user_provider.dart';

class ProfileMeScreenNew extends HookConsumerWidget {
  const ProfileMeScreenNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User not found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Image Section
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg', // Replace with your image URL
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 16),
                // User Info Section
                Text(
                  user.username,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  user.phone,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                // User Role Section
                Text(
                  'Role: ${user.role}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // User Status Section
                Text(
                  'Status: ${user.status ? "Active" : "Inactive"}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
