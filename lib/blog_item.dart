class BlogItem {
  static int _counter = 0;

  int id; // Updated to include id property
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
    int? id, // Added optional id parameter
  }) : id = id ??
            _counter++; // Assign id or auto-increment _counter if id is null

  // Other methods and properties...

  // Convert BlogItem to Map for database operations
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

  // Create BlogItem from Map for database operations
  static BlogItem fromMap(Map<String, dynamic> map) {
    return BlogItem(
      id: map['id'],
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
