import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lanchonete/models/product_model.dart';
import 'package:lanchonete/widgets/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List _products = [];

  Future<List<Product>> _getProducts() async {
    final String response = await rootBundle.loadString('mocks/produtos.json');
    final data = jsonDecode(response);
    final list = data.map((e) => Product.fromJson(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: const [
            ProductWidget(),
            ProductWidget(),
          ],
        ),
      ),
    );
  }
}