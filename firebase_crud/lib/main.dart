import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/pages/login_page.dart';
import 'package:firebase_crud/theme/dark_theme.dart';
import 'package:firebase_crud/theme/light_theme.dart';
import 'package:firebase_crud/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        darkTheme: darktheme,
        home: const LoginPage());
  }
}
