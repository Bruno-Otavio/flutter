import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/database_service.dart';

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
  final DatabaseService _databaseService = DatabaseService.instance;

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
              child: FavoriteButton(databaseService: _databaseService, pokemon: widget.pokemon),
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

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required DatabaseService databaseService,
    required this.pokemon,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;
  final Pokemon pokemon;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _favorited = false;

  void checkFavorited() async {
    final pokemon = await widget._databaseService.getFavorite(widget.pokemon.id);
    if (pokemon.isNotEmpty) {
      _favorited = true;
    } else {
      _favorited = false;
    }
  }

  Color favoriteColor() {
    if (_favorited) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    checkFavorited();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget._databaseService.addFavorite(widget.pokemon);
        print(_favorited);
        setState(() {
          _favorited = !_favorited;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: favoriteColor(),
            width: 2,
          )
        ),
        child: Icon(
          Icons.favorite,
          color: favoriteColor(),
        ),
      ),
    );
  }
}