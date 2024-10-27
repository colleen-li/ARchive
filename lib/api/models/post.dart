import 'package:cloud_firestore/cloud_firestore.dart';

class IPost {
  final String quote;
  final DateTime imprinted;

  IPost({
    required this.quote,
    required this.imprinted,
  });

  factory IPost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return IPost(
      quote: data?['quote'] as String,
      imprinted: (data?['imprinted'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'quote': quote,
      'imprinted': imprinted,
    };
  }
}
