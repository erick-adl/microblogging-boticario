import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PostEntity extends ChangeNotifier {
  PostEntity({
    this.id,
    this.name,
    this.text,
    this.createdAt,
  });
  String id;
  String name;
  String text;
  DateTime createdAt;
  String createdAtString;

  final Firestore firestore = Firestore.instance;
  DocumentReference get firestoreRef => firestore.document('feed/$id');

  PostEntity.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    text = document['text'] as String;
    createdAt = (document['createdAt'] as Timestamp).toDate();
    createdAtString = DateFormat('dd-MM-yyyy – HH:mm').format(createdAt);
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> toDocument() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'text': text,
      'createdAt': createdAt,
    };

    if (id == null) {
      final doc = await firestore.collection('feed').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    loading = false;
  }

  void delete() {
    firestoreRef.delete();
  }

  void update({String text}) {
    firestoreRef.updateData({'text': text});
  }
}
