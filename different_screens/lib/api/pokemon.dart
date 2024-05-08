import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Pokemon> fetchPokemon() async {
  final response = await http
    .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/1'));

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

class Pokemon {
  final String name;
  final List types;

  const Pokemon({
    required this.name,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'types': List types, 
      } => 
        Pokemon(
          name: name,
          types: types, 
        ),
      _ => throw const FormatException('Failed to load pokemon.'),
    };
  }
}
