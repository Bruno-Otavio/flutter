import 'package:flutter/material.dart';
import 'package:different_screens/models/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel> products = [];

  void _getProducts() {
    products = ProductModel.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    _getProducts();
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container();
              },
            )
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Products'),
    );
  }
}