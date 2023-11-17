import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static DBManager? _instance;
  static DBManager getInstance() => _instance ??= DBManager();

  static Database? _database;
  Future<Database> get getDatabase async => _database ??= await _loadDatabase();

  Future<Database> _loadDatabase() async {
    // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'post.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE post(id INTEGER PRIMARY KEY, title TEXT,desc TEXT, price TEXT,imgs TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}
