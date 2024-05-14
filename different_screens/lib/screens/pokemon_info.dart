import 'package:different_screens/api/pokemon.dart';
import 'package:flutter/material.dart';

class PokeInfoScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokeInfoScreen({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokeInfoScreen> createState() => _PokeInfoScreenState();
}

class _PokeInfoScreenState extends State<PokeInfoScreen> {
  late Future<PokemonInfo> futurePokemon;

  @override
  void initState() {
    super.initState();
    futurePokemon = PokeController.fetchPokeInfo(widget.pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: FutureBuilder<PokemonInfo>(
        future: futurePokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PokemonInfo pokemon = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          spreadRadius: 0.0,
                          offset: Offset(0, 5)
                        )
                      ]
                    ),
                    child: Image.network(
                      pokemon.sprites['front_default'],
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                                  
                        return const Center(child: CircularProgressIndicator(),);
                      },
                      height: 200,
                      fit: BoxFit.contain
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                      '${pokemon.types[0]['type']['name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('${snapshot.error}');
          }
        },
      )
    );
  }
}
