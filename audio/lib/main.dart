import 'package:audio/screens/home.dart';
import 'package:audio/screens/regexr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/audio',
      routes: {
        '/audio': (context) => const HomeScreen(),
        '/regexr': (context) => const RegExrScreen(),
      },
    );
  }
}
