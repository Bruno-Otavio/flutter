import 'package:firebase_crud/services/auth_service.dart';
import 'package:firebase_crud/widgets/button.dart';
import 'package:firebase_crud/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerKey = GlobalKey<FormState>();

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
            'Register Account',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Form(
            key: _registerKey,
            child: Column(
              children: [
                InputText(controller: _emailController, placeholder: 'Email'),
                InputText(
                  controller: _passwordController,
                  placeholder: 'Password',
                  obscure: true,
                ),
                Button(
                  onPressed: () async {
                    if (_registerKey.currentState!.validate()) {
                      await AuthService().singUp(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                    }
                  },
                  text: 'Register',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
