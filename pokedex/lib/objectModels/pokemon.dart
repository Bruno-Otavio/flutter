import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonController {
  static Future<List<Pokemon>> fetchPokemons() async {
    final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151&offset=0'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)['results'];

      return body.map((e) => Pokemon.fromJson(e, body.indexOf(e))).toList();
    } else {
      throw Exception('Failed to load the Pokemons');
    }
  }
}

class Pokemon {
  final String name;
  final String url;
  final String imageUrl;

  const Pokemon({
    required this.name,
    required this.url,
    required this.imageUrl
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, int id) {
    return switch (json) {
      {
        'name': String name,
        'url': String url,
      } => 
        Pokemon(
          name: name,
          url: url,
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'
        ),
      _ => throw const FormatException('Failed to load pokemon'),
    };
  }
}
