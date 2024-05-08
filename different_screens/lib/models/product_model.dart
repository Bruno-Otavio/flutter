import 'package:flutter/material.dart';

class ProductModel {
  String name;
  String imagePath;
  Color boxColor;
  double price;

  ProductModel({
    required this.name,
    required this.imagePath,
    required this.boxColor,
    required this.price,
  });

  static List<ProductModel> getProducts() {
    List<ProductModel> products = [];

    products.add(
      ProductModel(
        name: 'Hamburguer',
        imagePath: 'assets/images/hamburguer.jpg',
        boxColor: Colors.blueGrey,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Coca-Cola',
        imagePath: 'assets/images/coca-cola.jpg',
        boxColor: Colors.yellow,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Pão',
        imagePath: 'assets/images/pao.jpg',
        boxColor: Colors.pink,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Pão',
        imagePath: 'assets/images/pao.jpg',
        boxColor: Colors.pink,
        price: 45.5
      )
    );
    
    products.add(
      ProductModel(
        name: 'Pão',
        imagePath: 'assets/images/pao.jpg',
        boxColor: Colors.pink,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Pão',
        imagePath: 'assets/images/pao.jpg',
        boxColor: Colors.pink,
        price: 45.5
      )
    );
    
    return products;
  }
}

class ProductModelWidget extends StatelessWidget {
  final ProductModel product;

  const ProductModelWidget({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Row(
        children: [
          productImage(),
          productInfo(),
        ],
      ),
    );
  }

  Padding productInfo() {
    return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Price: ${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                ),
                onPressed: () {},
                child: const Text('Add to Cart')
              )
            ],
          ),
        );
  }

  ClipRRect productImage() {
    return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 40,
                  spreadRadius: 0.0
                )
              ]
            ),
            child: Image.asset(
              product.imagePath,
              width: 175,
              fit: BoxFit.cover,
            ),
          ),
        );
  }
}
