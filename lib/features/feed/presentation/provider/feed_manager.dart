import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:microblogging/features/feed/domain/entities/post_entity.dart';

class FeedManager extends ChangeNotifier {
  FeedManager() {
    _loadFeed();
  }
  final Firestore firestore = Firestore.instance;

  List<PostEntity> feedList = [];

  Future<void> _loadFeed() async {
    firestore
        .collection('feed')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      feedList.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        feedList.add(PostEntity.fromDocument(document));
      }
      notifyListeners();
    });
  }

  post({String user, String text}) {
    final post = PostEntity(createdAt: DateTime.now(), name: user, text: text);
    post.toDocument();
  }

  void delete(String id) {}
}
