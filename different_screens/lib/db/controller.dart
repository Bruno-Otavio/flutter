import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  static Future<Database> connect() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(await getDatabasesPath(), 'pokemonDatabase.db'),
      
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT, url TEXT, imageUrl TEXT)'
        );
      },

      version: 1
    );

    return database;
  }
  
  Future<void> insert(Future<Database> database, String table, Map<String, Object?> object) async {
    final db = await database;

    await db.insert(
      table,
      object,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List> get(Future<Database> database, String table) async {
    final db = await database;

    final List<Map<String, Object?>> objectMaps = await db.query(table);

    return objectMaps;
  }

  Future<void> delete(Future<Database> database, String table, int id) async {
    final db = await database;

    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
