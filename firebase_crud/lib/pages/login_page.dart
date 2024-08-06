import 'package:firebase_crud/pages/register_page.dart';
import 'package:firebase_crud/services/auth_service.dart';
import 'package:firebase_crud/widgets/button.dart';
import 'package:firebase_crud/widgets/input_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login Firebase',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Form(
            key: _loginKey,
            child: Column(
              children: [
                InputText(controller: _emailController, placeholder: 'Email'),
                InputText(
                  controller: _passwordController,
                  placeholder: 'Password',
                  obscure: true,
                ),
                Button(
                  text: 'Login',
                  onPressed: () async {
                    if (_loginKey.currentState!.validate()) {
                      await AuthService().signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                    }
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  ),
                  child: Text(
                    'Crie uma nova conta.',
                    style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
