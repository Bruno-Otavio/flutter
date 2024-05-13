import 'package:different_screens/api/pokemon.dart';
import 'package:flutter/material.dart';

class PokeInfoScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokeInfoScreen({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokeInfoScreen> createState() => _PokeInfoScreenState();
}

class _PokeInfoScreenState extends State<PokeInfoScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(widget.pokemon.name),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
