import 'package:appspertanian/models/liked_product_model.dart';
import 'package:appspertanian/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        username TEXT,
        phone TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE liked_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        price TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    try {
      return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      return -1;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> insertLikedProduct(LikedProduct product) async {
    final db = await database;
    try {
      return await db.insert(
        'liked_products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      return -1;
    }
  }

  Future<List<LikedProduct>> getLikedProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('liked_products');
    return List.generate(maps.length, (i) {
      return LikedProduct.fromMap(maps[i]);
    });
  }

  Future<int> deleteLikedProductByName(String name) async {
    final db = await database;
    return await db.delete(
      'liked_products',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<bool> isProductLiked(String productName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'liked_products',
      where: 'name = ?',
      whereArgs: [productName],
    );
    return maps.isNotEmpty;
  }
}
