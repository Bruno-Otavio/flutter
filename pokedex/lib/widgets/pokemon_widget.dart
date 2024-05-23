import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonWidget extends StatefulWidget {
  final Pokemon pokemon; 

  const PokemonWidget({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokemonWidget> createState() => _PokemonWidgetState();
}

class _PokemonWidgetState extends State<PokemonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          '/pokemons/details', 
          arguments: widget.pokemon, 
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.red.shade300
          ),
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey
            )
          ]
        ),
        child: Column(
          children: [
            Hero(
              tag: widget.pokemon.imageUrl,
              child: Image.network(
                widget.pokemon.imageUrl,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              widget.pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}