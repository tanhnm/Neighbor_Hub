import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/navbar_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // Sample list of activity notifications
  final List<String> activityNotifications = [
    "Activity 1: You joined a new group.",
    "Activity 2: Your post received a like.",
    "Activity 3: You have a new follower.",
    "Activity 4: Your comment was replied to.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const BottomNavBar())); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: activityNotifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(activityNotifications[index]),
            leading: const Icon(Icons.notifications),
          );
        },
      ),
    );
  }
}
