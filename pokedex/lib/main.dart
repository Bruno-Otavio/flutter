import 'package:flutter/material.dart';
import 'package:pokedex/home.dart';
import 'package:pokedex/screens/login_page.dart';
import 'package:pokedex/screens/pokemon_details_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/pokemons/details': (context) => const PokemonDetailsPage(),
      }
    );
  }
}
