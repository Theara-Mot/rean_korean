import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'translations.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE translations(id INTEGER PRIMARY KEY, korean TEXT, khmer TEXT, date TEXT)",
        );
      },
    );
  }

  Future<int> insertTranslation(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('translations', row);
  }

  Future<List<Map<String, dynamic>>> getTranslations() async {
    Database db = await database;
    return await db.query('translations');
  }

  Future<int> updateTranslation(Map<String, dynamic> row) async {
    Database db = await database;
    int id = int.parse(row['id']);
    return await db.update('translations', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTranslation(int id) async {
    Database db = await database;
    return await db.delete('translations', where: 'id = ?', whereArgs: [id]);
  }
}
