import 'package:flutter/material.dart';
import 'package:pokedex/screens/favorites.dart';
import 'package:pokedex/screens/pokemons.dart';
import 'package:pokedex/screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    PokemonsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokedex'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          )
        ],
        selectedItemColor: Colors.red,
        selectedFontSize: 16,
        selectedIconTheme: const IconThemeData(
          size: 30,
          shadows: [
            Shadow(
               blurRadius: 25,
               color: Colors.grey
            )
          ]
        ),
      ),
    );
  }
}