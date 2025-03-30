// ignore_for_file: avoid_print

import 'dart:io';

import 'package:food_dairy_app/model.dart/RecppeModel.dart';
import 'package:food_dairy_app/model.dart/UserModel.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  static const String tableName = 'recipes';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    // deleteOldDatabase();
    print("Database created");
    String path = join(await getDatabasesPath(), 'food_dairy.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            image TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
        ''');
      },
    );
  }

  static Future<void> createUsersTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      email TEXT,
      password TEXT,
      phone TEXT,
      dob TEXT,
      image TEXT
    )
  ''');
  }

  static Future<void> createRecipesTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE recipes (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      imageUrl TEXT,
      calories TEXT,
      protein TEXT,
      prepTime TEXT
    )
  ''');
  }

  static Future<void> deleteOldDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userDB.db');

    if (await File(path).exists()) {
      await File(path).delete();
      print("Old database deleted");
    }
  }

  static Future<void> insertUser(UserModel user) async {
    final dbClient = await database;
    await dbClient!.insert('users', user.toMap());
  }

  static Future<void> insertRecipe(Recipe r) async {
    final dbClient = await database;
    await dbClient!.insert('recipes', r.toMap());
  }

  static Future<void> updateUserById(int id, UserModel updatedUser) async {
    final dbClient = await database;
    await dbClient!.update(
      'users',
      updatedUser.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Recipe?>?> getAllRecipes() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(tableName);
      List<Recipe> recipe = List.generate(maps.length, (i) {
        return Recipe(
          id: maps[i]['id'].toString(),
          name: maps[i]['name'],
          description: maps[i]['description'],
          imageUrl: maps[i]['image'],
          calories: maps[i]['calories'],
          protein: maps[i]['protein'],
          prepTime: maps[i]['prepTime'],
        );
      });
      StaticData.yourrecipe = recipe;
      return recipe;
    } catch (e) {
      print("errorrr     $e");
      return null;
    }
  }

  static Future<UserModel?> getUserByEmailAndPassword(
      String email, String password) async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isEmpty) {
      print("dadada$maps");
      return null;
    }
    UserModel model = UserModel(
      id: maps[0]['id'].toString(),
      username: maps[0]['username'],
      email: maps[0]['email'],
      phone: maps[0]['phone'],
      password: maps[0]['password'],
      dob: maps[0]['dob'],
      image: maps[0]['image'],
    );
    print("sofjnsngfg$model");
    return model;
  }

  static Future<void> updateUser(UserModel user) async {
    final dbClient = await database;
    await dbClient!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(int id) async {
    final dbClient = await database;
    await dbClient!.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> close() async {
    final dbClient = await database;
    dbClient!.close();
  }
}
