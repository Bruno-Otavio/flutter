import 'package:flutter/material.dart';
import 'package:different_screens/api/pokemon.dart';

class PokemonWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonWidget({
    super.key, 
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(pokemon.name),
        ],
      ),
    );
  }
}
