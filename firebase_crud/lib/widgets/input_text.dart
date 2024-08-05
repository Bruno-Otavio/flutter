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
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: placeholder,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
