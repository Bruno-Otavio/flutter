import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/database_service.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({
    super.key,
    required this.favorite,
  });

  final Pokemon favorite;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/pokemons/details', arguments: widget.favorite);
        },
        onLongPress: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: Text('Do you want to remove ${widget.favorite.name} from favorites?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, 
                  ),
                  TextButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      _databaseService.removeFavorite(widget.favorite.id);
                      Navigator.of(context).pop();
                    }, 
                  ),
                ],
              );
            }
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.red.shade100,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey
              )
            ]
          ),
          child: Row(
            children: [
              Image.network(
                widget.favorite.imageUrl,
                width: 100,
                fit: BoxFit.contain,
              ),
              Text(widget.favorite.name.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}