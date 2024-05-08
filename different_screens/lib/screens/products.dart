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
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductModelWidget(product: products[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0, color: Colors.white,),
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