import 'dart:io';
import 'package:path/path.dart';
import 'package:camera/camera.dart';
import 'package:educa/model/firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

//
class StorageProvider with ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;

  final firestore = Firestore();

  bool _isUploading = false;
  bool _isUploaded = false;

  bool get isUploading => _isUploading;
  bool get isUploaded => _isUploaded;

  // download Progress

  double _progress = 0;

  get downloadProgress => _progress;

  Future<void> store({XFile videofile, String title, String topic}) async {
    assert(videofile != null);
    File file = File(videofile.path);

    _progress = null;
    _isUploading = true;
    notifyListeners();

    UploadTask task = storage.ref(videofile.name).putFile(file);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      _progress = ((snapshot.bytesTransferred / snapshot.totalBytes) * 100)
          .roundToDouble();
      notifyListeners();
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    try {
      await task;

      _isUploaded = true;
      notifyListeners();

      String url = await storage.ref(videofile.name).getDownloadURL();

      await firestore.addVideo(title: title, topic: topic, url: url);

      print('Upload complete.');

      resetValues();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
    }
  }

  Future<String> getDownloadUrl(name) async {
    return await storage.ref(name).getDownloadURL();
  }

  void resetValues() {
    _progress = 0;
    _isUploading = false;
    _isUploaded = false;
    notifyListeners();
  }

  Future<void> uploadImage({File image, String username}) async {
    final name = basename(image.path);
    try {
      await storage.ref('Image/$name').putFile(image);

      String url = await storage.ref('Image/$name').getDownloadURL();

      print(url);

      await firestore.addImage(username: username, url: url);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'

      print(e.message);
    }
  }
}
