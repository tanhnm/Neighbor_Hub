import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/auth/profile_screen.dart';
import 'package:hive/hive.dart';

class MessageScreen extends StatefulWidget {
  final Map<String, dynamic> driver;
  final Map<String, dynamic> booking;
  final int registrationId;
  const MessageScreen(
      {super.key,
      required this.driver,
      required this.booking,
      required this.registrationId});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  final TextEditingController _controller = TextEditingController();

  final CollectionReference _messagesRef =
      FirebaseFirestore.instance.collection('chats');
  int currentUserId = 0; // Example user ID, use FirebaseAuth for real user ID

  Future<void> getUserInfo() async {
    var userBox = await Hive.openBox<User>('users');
    if (userBox.get('user')?.userId == null) {
      throw Exception('User not found');
    }
    currentUserId = userBox.get('user')!.userId;
    print(currentUserId);
  }

  void _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    try {
      await _messagesRef.add({
        'booking': '${widget.booking['bookingId']}',
        'text': message,
        'senderId': currentUserId.toString(),
        'driverId': widget.driver['driverId'],
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    } catch (e) {
      print('Error sending message: $e'); // Print any error to debug console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhắn Tin với ${widget.driver['username']}'),
      ),
      body: Column(
        children: [
          // Header with User Image and Username
          GestureDetector(
            onTap: () {
              Map<String, dynamic> driver = {
                'username': widget.driver['username'],
                'driverId': widget.driver['driverId'],
                'phone': widget.driver['phone'],
                'email': widget.driver['email'],
                'averageRating': widget.driver['averageRating'],
                'revenue': widget.driver['revenue'],
              };
              // Navigate to profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    driver: {
                      "driverId": 1,
                      "username": widget.driver['username'],
                      "phone": widget.driver['phone'],
                      "email": widget.driver['email'],
                      'averageRating': widget.driver['averageRating'],
                      'revenue': widget.driver['revenue'],
                    },
                    booking: widget.booking,
                    registrationFormId: widget.registrationId,
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
                  Text(widget.driver['username'],
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          // Chat messages stream
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesRef
                  .where('booking', isEqualTo: '${widget.booking['bookingId']}')
                  .where('driverId', isEqualTo: widget.driver['driverId'])
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
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
                        message['senderId'] == currentUserId.toString();

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
                    controller: _controller,
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
