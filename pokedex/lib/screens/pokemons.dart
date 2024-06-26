import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/pokemon_widget.dart';
import 'package:pokedex/controller/pokemon_controller.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  late Future<List<Pokemon>> futurePokemon;

  @override
  void initState() {
    super.initState();
    futurePokemon = PokemonController.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pokemons',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemon, 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Pokemon> pokemons = snapshot.data!;
            return _buildPokemons(pokemons);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
    
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget _buildPokemons(List<Pokemon> pokemons) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(15),
      children: List.generate(pokemons.length, (index) {
        final Pokemon pokemon = pokemons[index];
        return PokemonWidget(pokemon: pokemon);
      })
    );
  }
}