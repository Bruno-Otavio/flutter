import 'package:flutter/material.dart';
import 'package:lanchonete/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List cartProducts = [];
  
  List get cart {
    return cartProducts;
  }

  void addToCart({ required Product product}) async {
    cartProducts.add(product);
    notifyListeners();
  } 

  void removeFromCart({ required Product product}) async {
    cartProducts.remove(product);
    notifyListeners();
  }

  void clearCart() {
    cartProducts.clear();
    notifyListeners();
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var p in cartProducts) {
      total += p.preco * p.quantity;
    }
    return total;
  }

  double totalProducts() {
    double total = 0;
    for (var p in cartProducts) {
      total += p.quantity;
    }
    return total;
  }
}