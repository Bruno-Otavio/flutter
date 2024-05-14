import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:different_screens/models/pokemon_model.dart';
import 'package:different_screens/api/pokemon.dart';
import 'package:different_screens/db/controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Pokemon>> futurePokemon;

  late final Future<Database> db;

  @override
  void initState() {
    super.initState();
    futurePokemon = PokeController.fetchPokemon();
    db = DatabaseController.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Pokemon> pokemons = snapshot.data!;
            return buildPokemons(pokemons, db);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      )
      // body: ListView.separated(
      //   itemCount: products.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ProductModelWidget(product: products[index]);
      //   },
      //   separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0, color: Colors.white,),
      // ),
    );
  }

  Widget buildPokemons(List<Pokemon> pokemons, Future<Database> database) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(pokemons.length, (index) {
        final Pokemon pokemon = pokemons[index];
        return PokemonWidget(pokemon: pokemon, db: database);
      })
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Pokemons'),
    );
  }
}
