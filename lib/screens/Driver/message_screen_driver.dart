import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/Driver/user_info_screen.dart';
import 'package:flutter_application_1/services/driver_service/driver_service.dart';

class MessageScreenDriver extends StatefulWidget {
  final Map<String, dynamic>
      user; // Contains user details (userId, username, phone)
  final Booking booking;
  final int driver;
  const MessageScreenDriver(
      {super.key,
      required this.user,
      required this.booking,
      required this.driver});

  @override
  _MessageScreenDriverState createState() => _MessageScreenDriverState();
}

class _MessageScreenDriverState extends State<MessageScreenDriver> {
  final TextEditingController _messageController = TextEditingController();
  final CollectionReference _messagesRef = FirebaseFirestore.instance
      .collection('chats'); // Use 'messages' collection

  String currentUserId = '';
  @override
  void initState() {
    // loadUser();
    currentUserId = widget.driver.toString();
  }

  // Send message function
  void _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      await _messagesRef.add({
        'booking': '${widget.booking.booking.bookingId}',
        'text': messageText,
        'userId': widget.user['userId'].toString(),
        'senderId': currentUserId.toString(),
        'driverId': currentUserId.toString(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  // Future<void> loadUser() async {
  //   var userBox = Hive.box<User>('users');
  //   setState(() {
  //     print("driver: ${userBox.get('user')?.userId.toString() ?? ''}");
  //     currentUserId = userBox.get('user')?.userId.toString() ?? '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.user['username']}'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(
                    user: {
                      "username": widget.user['username'],
                      "phone": widget.user['phone'],
                      "email": widget.user['email'],
                      "location": widget.user['location'],
                      "destination":
                          widget.user['destination'], // Add this line
                    },
                    booking: widget.booking,
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
                  Text(widget.user['username'],
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
                      isEqualTo: widget.booking.booking.bookingId.toString())
                  .where('driverId', isEqualTo: widget.driver.toString())
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
                    controller: _messageController,
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
