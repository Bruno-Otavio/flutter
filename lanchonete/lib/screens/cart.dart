import 'package:flutter/material.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:lanchonete/widgets/cart_product_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final renderedProducts = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cart = provider.cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho da Beth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final product = cart[index];
            return CartProductWidget(product: product);
          },
        ),
      ),
    );
  }
}