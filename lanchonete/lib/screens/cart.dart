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
  @override
  void initState() {
    super.initState();
  }

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
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: R\$ ${provider.calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.surface
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/send');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onTertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  overlayColor: Theme.of(context).colorScheme.surface
                ),
                child: Text(
                  'Finalizar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.surface
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}