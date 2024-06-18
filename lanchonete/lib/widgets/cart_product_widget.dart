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
      ),
      color: Colors.white,
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
                width: 105,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 17
                      ),
                    ),
                    Text(
                      'R\$ ${widget.product.precoFinal.toStringAsFixed(2)}'
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    provider.removeFromCart(product: widget.product);
                  },
                  icon: const Icon(Icons.close),
                  color: Theme.of(context).colorScheme.onSecondary,
                  iconSize: 30,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.product.quantity--;
                        });
                        if (widget.product.quantity < 1) {
                          provider.removeFromCart(product: widget.product);
                        }
                      },
                      child: Container(
                        height: 35,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                          ),
                          color: Theme.of(context).colorScheme.onSecondary
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      color: Theme.of(context).colorScheme.surface,
                      child: Center(
                        child: Text(
                          '${widget.product.quantity}',
                          style: const TextStyle(
                            fontSize: 25
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.product.quantity++;
                        });
                      },
                      child: Container(
                        height: 35,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          )
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}