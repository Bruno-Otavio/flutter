import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              'https://raw.githubusercontent.com/wellifabio/senai2023/main/2des/projetos/assets/cantina/coxinha.png',
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const ListTile(
                  title: Text('Produto 1'),
                ),
                ElevatedButton(
                  onPressed: () {}, 
                  child: const Text('Adicionar ao Carrinho',
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}