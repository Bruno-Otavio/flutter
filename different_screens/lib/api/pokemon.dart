import 'package:http/http.dart' as http;
import 'dart:convert';

class PokeController {
  static Future<List<Pokemon>> fetchPokemon() async {
    final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=300&offset=0'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List body = jsonDecode(response.body)['results'];

      return body.map((e) => Pokemon.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pokemon');
    }
  }

  static Future<PokemonInfo> fetchPokeInfo(String url) async {
    final response = await http
      .get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PokemonInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load pokemon informations');
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
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'url': String url,
      } => 
        Pokemon(
          name: name,
          url: url,
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${url.split('/')[url.split('/').length-2]}.png'
        ),
      _ => throw const FormatException('Failed to load pokemon.'),
    };
  }
}

class PokemonInfo {
  final int id;
  final String name;
  final List types;
  final Map sprites;

  const PokemonInfo({
    required this.id,
    required this.name,
    required this.types,
    required this.sprites,
  });

  factory PokemonInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String name,
        "types": List types,
        "sprites": Map sprites,
      } => 
        PokemonInfo(
          id: id,
          name: name,
          types: types,
          sprites: sprites,
        ),
      _ => throw const FormatException('Failed to load pokemon informations.'),
    };
  }
}
