import 'package:archive/api/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionName = "posts";

  String _getCollectionPath() {
    return _collectionName;
  }

  Future addPost(String quote, vector.Vector3 position,
      vector.Vector4 _rotation, Position geoPos) async {
    final IPost post = IPost(
      position: position,
      rotation: _rotation,
      latitude: geoPos.latitude,
      longitude: geoPos.longitude,
      userId: _auth.currentUser!.uid,
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

  Future<QuerySnapshot<IPost>> getPostsById() {
    return _firestore
        .collection(_getCollectionPath())
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .withConverter(
          fromFirestore: IPost.fromFirestore,
          toFirestore: (IPost post, options) => post.toFirestore(),
        )
        .get();
  }

  Future<QuerySnapshot<IPost>> getPostsNearby(Position position) {
    final double lat = position.latitude;
    final double lon = position.longitude;
    final double latMin = lat - 0.1;
    final double latMax = lat + 0.1;
    final double lonMin = lon - 0.1;
    final double lonMax = lon + 0.1;

    debugPrint("latMin: $latMin");
    debugPrint("latMax: $latMax");
    debugPrint("lonMin: $lonMin");
    debugPrint("lonMax: $lonMax");

    return _firestore
        .collection(_getCollectionPath())
        .where("latitude", isGreaterThan: latMin)
        .where("latitude", isLessThan: latMax)
        .where("longitude", isGreaterThan: lonMin)
        .where("longitude", isLessThan: lonMax)
        .withConverter(
          fromFirestore: IPost.fromFirestore,
          toFirestore: (IPost post, options) => post.toFirestore(),
        )
        .get();
  }
}
