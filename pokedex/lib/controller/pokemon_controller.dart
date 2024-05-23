import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';

class PokemonController {
  static Future<List<Pokemon>> fetchPokemons() async {
    final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151&offset=0'));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body)['results'];

      return body.map((e) => Pokemon.fromJson(e, body.indexOf(e))).toList();
    } else {
      throw Exception('Failed to load the Pokemons');
    }
  }

  static Future<PokemonDetails> fetchPokemon(int id) async {
    final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon$id'));

    if (response.statusCode == 200) {
      return PokemonDetails.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
