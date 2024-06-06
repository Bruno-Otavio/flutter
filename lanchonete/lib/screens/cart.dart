import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:lanchonete/widgets/cart_product_widget.dart';
import 'package:lanchonete/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cart = provider.cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return CartProductWidget(product: cart[index]);
        },
      ),
    );
  }
}