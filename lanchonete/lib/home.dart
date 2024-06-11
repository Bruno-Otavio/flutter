import 'package:flutter/material.dart';
import 'package:lanchonete/screens/cart.dart';
import 'package:lanchonete/screens/products.dart';
import 'package:lanchonete/screens/send.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  final List _screens = const [
    CartScreen(),
    ProductsScreen(),
    SendScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: ''
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        selectedIconTheme: IconThemeData(
          size: 30,
          color: Theme.of(context).colorScheme.surface
        ),
      ),
    );
  }
}

