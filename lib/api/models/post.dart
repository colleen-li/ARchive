import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class IPost {
  final String quote;
  final DateTime imprinted;
  final int likes;
  final String userId;
  final vector.Vector3 position;
  final vector.Vector4 rotation;
  final double latitude;
  final double longitude;

  IPost({
    required this.position,
    required this.rotation,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.quote,
    required this.imprinted,
    this.likes = 0,
  });

  factory IPost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return IPost(
      userId: snapshot.id,
      quote: data?['quote'] as String,
      imprinted: (data?['imprinted'] as Timestamp).toDate(),
      likes: data?['likes'] as int,
      position: vector.Vector3(
        data?['position'][0] as double,
        data?['position'][1] as double,
        data?['position'][2] as double,
      ),
      rotation: vector.Vector4(
        data?['rotation'][0] as double,
        data?['rotation'][1] as double,
        data?['rotation'][2] as double,
        data?['rotation'][3] as double,
      ),
      latitude: (data?['coords'] as GeoPoint).latitude,
      longitude: (data?['coords'] as GeoPoint).longitude,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'quote': quote,
      'userId': userId,
      'imprinted': imprinted,
      'likes': likes,
      'position': [position.x, position.y, position.z],
      'rotation': [rotation.x, rotation.y, rotation.z, rotation.w],
      'coords': GeoPoint(latitude, longitude),
    };
  }
}
