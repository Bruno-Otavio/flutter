import 'package:sqflite/sqflite.dart';

import 'package:different_screens/screens/pokemon_info.dart';
import 'package:flutter/material.dart';
import 'package:different_screens/api/pokemon.dart';
import 'package:different_screens/db/controller.dart';

class PokemonWidget extends StatefulWidget {
  final Pokemon pokemon;
  final Future<Database> db;

  const PokemonWidget({
    super.key, 
    required this.pokemon,
    required this.db
  });

  @override
  State<PokemonWidget> createState() => _PokemonWidgetState();
}

class _PokemonWidgetState extends State<PokemonWidget> {
  final dbController = DatabaseController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PokeInfoScreen(pokemon: widget.pokemon))
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
                offset: Offset(0, 5),
              )
            ]
          ),
          child: Column(
            children: [
              Image.network(widget.pokemon.imageUrl),
              Text(
                widget.pokemon.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              _favoriteButton()
            ],
          )
        ),
      ),
    );
  }

  GestureDetector _favoriteButton() {
    return GestureDetector(
      onTap: () {
        print('tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Favorite',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
