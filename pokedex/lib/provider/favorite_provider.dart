import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/database_service.dart';

Future<List<Pokemon>> getFavorites() async {
  final DatabaseService _databaseService = DatabaseService.instance;

  final data = await _databaseService.getFavorites();

  return data;
}

class FavoriteProvider extends ChangeNotifier {
  final Future<List<Pokemon>> _favorites = getFavorites();

  void toggleFavorite(Pokemon favorite) {
    return;
  }
}