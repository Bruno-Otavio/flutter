import 'package:flutter/material.dart';
import 'package:lanchonete/models/product_model.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartProductWidget extends StatefulWidget {
  final Product product;
  final int quantity;

  const CartProductWidget({
    super.key,
    required this.product,
    this.quantity = 1,
  });

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary
        )
      ),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                widget.product.img,
                width: 125,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.product.nome),
                    subtitle: Text('R\$ ${widget.product.preco} Qtd. ${widget.quantity}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.toggleCart(product: widget.product);
                    }, 
                    child: const Text('Remover do Carrinho')
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}