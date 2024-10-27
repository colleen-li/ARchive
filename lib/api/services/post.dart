import 'package:archive/api/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionName = "posts";

  String _getCollectionPath() {
    return _collectionName;
  }

  Future addPost(String quote) async {
    final IPost post = IPost(
      quote: quote,
      imprinted: DateTime.now(),
    );

    await _firestore
        .collection(_getCollectionPath())
        .withConverter(
          fromFirestore: IPost.fromFirestore,
          toFirestore: (IPost post, options) => post.toFirestore(),
        )
        .add(post)
        .then((documentSnapshot) =>
            debugPrint("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<QuerySnapshot<IPost>> getPosts() {
    return _firestore
        .collection(_getCollectionPath())
        .withConverter(
          fromFirestore: IPost.fromFirestore,
          toFirestore: (IPost post, options) => post.toFirestore(),
        )
        .get();
  }
}
