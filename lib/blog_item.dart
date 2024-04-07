class BlogItem {
  static int _counter = 1;
  int id;
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
  }) : id = _counter++;

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

  static BlogItem fromMap(Map<String, dynamic> map) {
    return BlogItem(
      title: map['title'],
      date: DateTime.parse(map["date"]),
      body: map['body'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      status: map['status'],
      deleted: map['deleted'] == 1,
    );
  }
}
