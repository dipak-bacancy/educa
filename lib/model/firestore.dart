import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Firestore with ChangeNotifier {
  CollectionReference videos = FirebaseFirestore.instance.collection('videos');
  CollectionReference images = FirebaseFirestore.instance.collection('images');

  Future<void> addVideo({String title, String topic, String url}) {
    return videos
        .add({
          'id': DateTime.now(),
          'title': title,
          'topic': topic,
          'url': url,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addImage({String username, String url}) {
    return images
        .add({
          'username': username,
          'url': url,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<QueryDocumentSnapshot>> getVideos() async {
    var querySnapshot = await videos.get();

    return querySnapshot.docs;
  }
}
