import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lanchonete/models/product_model.dart';
import 'package:lanchonete/widgets/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List> futureProducts;

  Future<List> _getProducts() async {
    final response = await rootBundle.loadString('lib/mocks/produtos.json');
    final data = jsonDecode(response);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    futureProducts = _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: futureProducts, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: List.generate(products.length, (index) {
                  final product = products[index];
                  return ProductWidget(product: product);
                }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
