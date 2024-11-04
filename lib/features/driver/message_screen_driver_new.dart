import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/driver/user_info_screen_new.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domains/freezed/booking_model.dart';
import '../../domains/user_model.dart';

class MessageScreenDriverNew extends HookConsumerWidget {
  const MessageScreenDriverNew(this.user, this.booking, this.driver, {super.key});

  final User user;
  final BookingModel booking;
  final int driver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final  messageController = useTextEditingController();

    final CollectionReference _messagesRef = FirebaseFirestore.instance
        .collection('chats'); // Use 'messages' collection

    final  currentUserId = useState(driver.toString());


    // Send message function
    void _sendMessage() async {
      final messageText = messageController.text.trim();
      if (messageText.isNotEmpty) {
        await _messagesRef.add({
          'booking': '${booking.booking.bookingId}',
          'text': messageText,
          'userId': user.userId.toString(),
          'senderId': currentUserId.toString(),
          'driverId': currentUserId.toString(),
          'timestamp': FieldValue.serverTimestamp(),
        });
        messageController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${user.username}'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoScreenNew(
                   user, booking
                  ),
                ),
              );
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
                  Text(user.username,
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          // Chat messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesRef
                  .where('booking',
                  isEqualTo: booking.booking.bookingId.toString())
                  .where('driverId', isEqualTo: driver.toString())
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == currentUserId;

                    return Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blueAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black),
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
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
