import 'package:flutter/material.dart';
import 'package:different_screens/models/product_model.dart';
import 'package:different_screens/api/pokemon.dart';
import 'package:flutter/widgets.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel> products = [];

  late Future<List<Pokemon>> futurePokemon;

  void _getProducts() {
    products = ProductModel.getProducts();
  }

  @override
  void initState() {
    super.initState();
    futurePokemon = PokeController.fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    _getProducts();
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Pokemon> pokemons = snapshot.data!;
            return buildPokemons(pokemons);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
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

  Widget buildPokemons(List<Pokemon> pokemons) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(pokemons.length, (index) {
        final Pokemon pokemon = pokemons[index];
        return Padding(
          padding: const EdgeInsets.all(15),
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
        );
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
