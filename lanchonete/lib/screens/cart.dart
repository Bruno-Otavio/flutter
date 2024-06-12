import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:lanchonete/widgets/cart_product_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List getRenderedProducts(List products) {
    final List rendered = [];

    for (int i = 0; i < products.length; i++) {
      if (!rendered.contains(products[i])) {
        products[i].quantity++;
        rendered.add(products[i]);
      }
    }

    return rendered;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cart = provider.cart;

    final List rendered = getRenderedProducts(cart);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho da Beth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: rendered.length,
          itemBuilder: (context, index) {
            final product = rendered[index];
            return CartProductWidget(product: product);
          },
        ),
      ),
    );
  }
}