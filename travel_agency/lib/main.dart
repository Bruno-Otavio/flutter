import 'package:flutter/material.dart';
import 'package:travel_agency/destinos.dart';
import 'package:travel_agency/maps_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MapsPage()
      home: DestinosPage()
    );
  }
}
