import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:firebase_crud/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<void> singUp({
    required email,
    required password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Weak Password';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email already in use';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        textColor: Theme.of(context).colorScheme.primary,
        fontSize: 20,
      );
    }
  }

  Future<void> signIn({
    required email,
    required password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'User not found';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        textColor: Theme.of(context).colorScheme.primary,
        fontSize: 20,
      );
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
