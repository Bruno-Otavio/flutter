import 'package:flutter/material.dart';

class ProductModel {
  String name;
  Icon icon;
  Color boxColor;
  double price;

  ProductModel({
    required this.name,
    required this.icon,
    required this.boxColor,
    required this.price,
  });

  static List<ProductModel> getProducts() {
    List<ProductModel> products = [];

    products.add(
      ProductModel(
        name: 'Hamburguer',
        icon: const Icon(
          Icons.fastfood,
          size: 50,
        ),
        boxColor: Colors.blueGrey,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Coca-Cola',
        icon: const Icon(
          Icons.emoji_food_beverage,
          size: 50,
        ),
        boxColor: Colors.blueGrey,
        price: 45.5
      )
    );

    products.add(
      ProductModel(
        name: 'Pão',
        icon: const Icon(
          Icons.fastfood,
          size: 50,
        ),
        boxColor: Colors.blueGrey,
        price: 45.5
      )
    );

    return products;
  }
}