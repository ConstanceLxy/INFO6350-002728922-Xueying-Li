

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStore {
  // For registering a new user
  static Future<String?> uploadImage({
    required String path,
  }) async {
    File file = File(path);
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();
    final arr = path.split("/");

    try {
      final mountainsRef = storageRef.child(arr.last);
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }

    return null;
  }

  static Future<String?> loadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final downloadUrl = await storageRef.getDownloadURL();
    print(downloadUrl);
    return null;
  }
}
