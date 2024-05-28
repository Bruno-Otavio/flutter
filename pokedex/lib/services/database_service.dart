import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _favoritesTableName = 'favorites';
  final String _favoritesIdColumnName = 'id';
  final String _favoritesPokemonName = 'pokemon';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dataBaseDirPath = await getDatabasesPath();
    final dataBasePath = join(dataBaseDirPath, 'pokedex_db.db');
    final database = await openDatabase(
      dataBasePath,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_favoritesTableName (
            $_favoritesIdColumnName INTEGER PRIMARY KEY auto_increment,
            $_favoritesTableName TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }
}