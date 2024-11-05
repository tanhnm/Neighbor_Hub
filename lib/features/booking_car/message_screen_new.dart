import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domains/freezed/driver_model.dart';
import 'package:flutter_application_1/features/auth/profile_screen_new.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:latlong2/latlong.dart';

import '../../common/routes.dart';
import '../../domains/freezed/booking_detail_model.dart';
import '../../domains/freezed/booking_model.dart';
import '../../domains/freezed/user_model.dart';
import '../../providers/user_provider.dart';

class MessageScreenNew extends HookConsumerWidget {
  const MessageScreenNew(
      {super.key, required this.bookingDetail, });

  final BookingDetailModel bookingDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final TextEditingController controller = useTextEditingController();
    final CollectionReference messagesRef =
        FirebaseFirestore.instance.collection('chats');
// State to store current user ID
    final currentUserId = useState<int>(0);

    // Fetch user info from Hive using useEffect (which replaces initState)
    useEffect(() {
      Future<void> getUserInfo() async {
        var userBox = Hive.box<UserModel>('users');
        if (userBox.get('user')?.userId == null) {
          throw Exception('User not found');
        }
        currentUserId.value = userBox.get('user')!.userId;
      }

      getUserInfo();
      return null; // Cleanup function not needed here
    }, []);


    // Function to send a message
    void _sendMessage() async {
      final message = controller.text.trim();
      if (message.isEmpty) return;

      try {
        await messagesRef.add({
          'booking': '${bookingDetail.bookingId}',
          'text': message,
          'senderId': currentUserId.value.toString(),
          'userId': currentUserId.value.toString(),
          'driverId': bookingDetail.registration!.driver!.driverId.toString(),
          'timestamp': FieldValue.serverTimestamp(),
        });
        controller.clear();
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error: $e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nhắn Tin với ${bookingDetail.registration!.driver!.username}'),
      ),
      body: Column(
        children: [
          // Header with User Image and Username
          GestureDetector(
            onTap: () {
              // Navigate to profile screen
              context.pushNamed(Routes.profileDriver, extra: bookingDetail);
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://media.muanhatructuyen.vn/post/226/50/3/hinh-nen-mau-hong-4k.jpg'), // Replace with your image URL
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(bookingDetail.registration!.driver!.username, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          // Chat messages stream
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesRef
                  .where('booking', isEqualTo: bookingDetail.bookingId.toString())
                  .where('driverId', isEqualTo: bookingDetail.registration!.driver!.driverId.toString())
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true, // Latest messages at the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final bool isMine =
                        message['senderId'] == currentUserId.value.toString();

                    return Align(
                      alignment:
                      isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.blue[300] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color: isMine ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Message input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
