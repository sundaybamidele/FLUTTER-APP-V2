import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'blog_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'blog_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE blog_items(
        id int PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        body TEXT NOT NULL,
        imageUrl TEXT,
        quantity INTEGER NOT NULL,
        status TEXT NOT NULL,
        deleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertBlogItem(BlogItem blogItem) async {
    Database db = await database;
    return await db.insert('blog_items', blogItem.toMap());
  }

  Future<List<BlogItem>> getBlogItems() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('blog_items');
    return List.generate(maps.length, (index) {
      return BlogItem.fromMap(maps[index]);
    });
  }

  Future<int> updateBlogItem(BlogItem blogItem) async {
    Database db = await database;
    return await db.update('blog_items', blogItem.toMap(),
        where: 'id = ?', whereArgs: [blogItem.id]);
  }

  Future<int> deleteBlogItem(int id) async {
    Database db = await database;
    return await db.delete('blog_items', where: 'id = ?', whereArgs: [id]);
  }
}
