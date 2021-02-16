import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

//
class StorageProvider {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> store({XFile videofile, String path}) async {
    assert(videofile != null);
    File file = File(videofile.path);
    print(videofile.mimeType);
    try {
      await storage.ref('$path.mp4').putFile(file);
    } on FirebaseException catch (e) {
      print(e.message);
      // e.g, e.code == 'canceled'
    }
  }
}
