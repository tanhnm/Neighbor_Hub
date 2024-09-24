import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 80, 20, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEF3167),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Huỳnh Nguyễn Minh Tân",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(2), // Space for the white border
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.white, width: 2), // White border
              ),
              child: ClipOval(
                child: Image.asset(
                  'images/Logo.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit
                      .cover, // Ensures the image fits nicely in the circle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
