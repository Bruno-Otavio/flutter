import 'package:flutter/material.dart';
import 'package:lanchonete/home.dart';
import 'package:lanchonete/provider/product_provider.dart';
import 'package:lanchonete/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightThemeData(context),
        home: const Home(),
      ),
    );
  }
}
