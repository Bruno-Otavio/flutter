import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifications/api/firebase_api.dart';
import 'package:notifications/firebase_options.dart';
import 'package:notifications/home.dart';
import 'package:notifications/notifications_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      navigatorKey: navigatorKey,
      routes: {
        '/notifications': (context) => const NotificationsScreen(),
      }
    );
  }
}
