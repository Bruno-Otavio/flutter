import 'package:http/http.dart' as http;
import 'dart:convert';

class PokeController {
  static Future<Pokemon> fetchPokemon() async {
  final response = await http
    .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50&offset=0'));

  var jsonData = jsonDecode(response.body);
  print(jsonData['results']);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pokemon');
  }
}
}

class Pokemon {
  final String name;
  final String url;

  const Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemons = json['results'];

    return switch (json) {
      {
        'name': String name,
        'url': String url,
      } => 
        Pokemon(
          name: name,
          url: url,
        ),
      _ => throw const FormatException('Failed to load pokemon.'),
    };
  }
}
