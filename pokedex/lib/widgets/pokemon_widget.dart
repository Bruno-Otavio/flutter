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
            color: Colors.red.shade100
          ),
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey
            )
          ]
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  print('Favorite ${widget.pokemon.name}');
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    )
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.pokemon.imageUrl,
                child: Image.network(
                  widget.pokemon.imageUrl,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                widget.pokemon.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}