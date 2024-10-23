import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageToFirebase(
    File image, String fileName, int userId) async {
  try {
    if (userId == 0) {
      throw Exception("User ID not found.");
    }

    // Upload image to Firebase Storage
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('users/$userId/$fileName'); // Store in user-specific folder
    UploadTask uploadTask = storageRef.putFile(image);

    TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully. URL: $downloadUrl');
      return downloadUrl;
    } else {
      throw Exception('Image upload failed');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
  return "";
}
