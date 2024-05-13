import 'package:different_screens/screens/pokemon_info.dart';
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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PokeInfoScreen(pokemon: pokemon))
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 5,
                spreadRadius: 0.0,
              )
            ]
          ),
          child: Column(
            children: [
              Image.network(pokemon.imageUrl),
              Text(
                pokemon.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
