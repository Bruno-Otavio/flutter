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
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: futureProducts, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductWidget(product: product);
                },
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
