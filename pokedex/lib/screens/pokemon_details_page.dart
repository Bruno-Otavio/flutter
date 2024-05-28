import 'package:flutter/material.dart';
import 'package:pokedex/controller/pokemon_controller.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_details.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late Future<PokemonDetails> futureDetails;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    futureDetails = PokemonController.fetchPokemon(pokemon.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25,),

            Hero(
              tag: pokemon.imageUrl,
              child: Image.network(
                pokemon.imageUrl,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            FutureBuilder<PokemonDetails>(
              future: futureDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final PokemonDetails details = snapshot.data!;
                  return _buildDetails(details);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const Center(child: CircularProgressIndicator(),);
              },
            )
          ],
        ),
      ),
    );
  }

  Column _buildDetails(PokemonDetails details) {
    return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 3
                        )
                      ),
                      child: Text(details.types[0]['type']['name']),
                    )
                  ],
                );
  }
}