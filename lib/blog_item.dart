import 'package:flutter/foundation.dart';

class BlogItem {
  int? id; // Added nullable ID for database usage
  String title;
  DateTime date;
  String body;
  String? imageUrl;
  int quantity;
  String status;
  bool deleted;

  BlogItem({
    required this.title,
    required this.date,
    required this.body,
    this.imageUrl,
    required this.quantity,
    required this.status,
    this.deleted = false,
  });

  // Convert BlogItem to Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'body': body,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'status': status,
      'deleted': deleted ? 1 : 0,
    };
  }

  // Create BlogItem object from a Map
  factory BlogItem.fromMap(Map<String, dynamic> map) {
    return BlogItem(
      title: map['title'],
      date: DateTime.parse(map['date']),
      body: map['body'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      status: map['status'],
      deleted: map['deleted'] == 1,
    );
  }
}
