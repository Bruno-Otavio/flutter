import 'package:flutter/material.dart';

class DestinosPage extends StatefulWidget {
  const DestinosPage({super.key});

  @override
  State<DestinosPage> createState() => _DestinosPageState();
}

class _DestinosPageState extends State<DestinosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Destinos'),),
      body: Container(),
    );
  }
}