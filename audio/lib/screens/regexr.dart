import 'package:audio/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegExrScreen extends StatefulWidget {
  const RegExrScreen({super.key});

  @override
  State<RegExrScreen> createState() => _RegExrScreenState();
}

class _RegExrScreenState extends State<RegExrScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegExr'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInput(
              hintText: 'Email',
              controller: _emailController,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              validator: (value) {
                final pattern = RegExp(r'@([A-Za-z0-9_.+-]+)\.[a-zA-z0-9_.+-]');
                if (value == null || value.isEmpty) {
                  return 'Fill the Input';
                } else if (!pattern.hasMatch(value)) {
                  return 'Invalid Email';
                }
                return null;
              },
            ),
            TextInput(
              hintText: 'Telefone',
              controller: _phoneController,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              validator: (value) {
                final pattern = RegExp(r'^\(([1-9][1-9])\)\s\d{5}\-\d{4}');
                if (value == null || value.isEmpty) {
                  return 'Fill the Input';
                } else if (!pattern.hasMatch(value)) {
                  return 'Invalid Phone';
                }
                return null;
              },
              inputFormatter: MaskTextInputFormatter(
                mask: '(xx) #####-####',
                filter: { '#': RegExp(r'[0-9]'), 'x': RegExp(r'[1-9]') },
                type: MaskAutoCompletionType.lazy,
              ),
            ),
            TextInput(
              hintText: 'CPF',
              controller: _cpfController,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              validator: (value) {
                final pattern = RegExp(r'\d{3}\.\d{3}.\d{3}\-\d{2}');
                if (value == null || value.isEmpty) {
                  return 'Fill the Input';
                } else if (!pattern.hasMatch(value)) {
                  return 'Invalid CPF';
                }
                return null;
              },
              inputFormatter: MaskTextInputFormatter(
                mask: '###.###.###-##',
                filter: { '#': RegExp(r'[0-9]') },
                type: MaskAutoCompletionType.lazy
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nice')),
                  );
                }
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
      drawer: const MenuDrawer(),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.inputFormatter,
    this.margin = EdgeInsets.zero,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputFormatter? inputFormatter;
  final String hintText;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        validator: validator,
        inputFormatters: inputFormatter == null ? [] : [inputFormatter!],
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
