import 'package:flutter/material.dart';
import 'package:lanchonete/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List cartProducts = [];
  
  List get cart {
    return cartProducts;
  }

  void toggleCart({ required Product product}) async {
    bool exists = cartProducts.contains(product);
    if (exists) {
      cartProducts.remove(product);
    } else if (!exists) {
      cartProducts.add(product);
    }
    notifyListeners();
  } 

  void clearCart() {
    cartProducts.clear();
    notifyListeners();
  }
}