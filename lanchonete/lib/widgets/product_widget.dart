import 'package:flutter/material.dart';
import 'package:lanchonete/models/product_model.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                widget.product.img,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              widget.product.nome,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R\$ ${widget.product.preco.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton.outlined(
                  onPressed: () {
                    provider.toggleCart(product: widget.product);
                  }, 
                  icon: const Icon(Icons.shopping_cart, size: 20,),
                  color: Theme.of(context).colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}