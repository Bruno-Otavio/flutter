import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required TextEditingController controller,
    required this.placeholder,
    this.obscure = false,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String placeholder;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $placeholder';
          }
          return null;
        },
        controller: _controller,
        obscureText: obscure,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.primary,
          filled: true,
          hintText: placeholder,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
