import 'dart:async';
import 'package:path/path.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _favoritesTableName = 'favorites';
  final String _favoritePokemonId = 'id';
  final String _favoritesPokemonName = 'pokemon';
  final String _favoritePokemonImage = 'image';

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
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_favoritesTableName (
            $_favoritePokemonId INTEGER PRIMARY KEY UNIQUE NOT NULL,
            $_favoritesPokemonName TEXT NOT NULL,
            $_favoritePokemonImage TEXT NOT NULL
          );
        ''');
      },
    );
    return database;
  }

  void addFavorite(Pokemon pokemon) async {
    final db = await database;
    await db.insert(
      _favoritesTableName, 
      {
        _favoritePokemonId: pokemon.id,
        _favoritesPokemonName: pokemon.name,
        _favoritePokemonImage: pokemon.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pokemon>> getFavorites() async {
    final db = await database;
    final data = await db.query(_favoritesTableName);
    return data.map((e) => Pokemon(
      id: e['id'] as int,
      name: e['pokemon'] as String,
      imageUrl: e['image'] as String,
    )).toList();
  }

  void removeFavorite(int id) async {
    final db = await database;
    await db.delete(
      _favoritesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}