import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  double _weight = 0;
  double _height = 0;

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  double calculateIMC(double weight, double height) {
    return weight / (height * height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          _inputField("Enter your Weight", weightController),
          _inputField("Enter your Height", heightController),
          _calculateButton(context)
        ],
      ),
    );
  }

  GestureDetector _calculateButton(BuildContext context) {
    return GestureDetector(
          onTap: () {
            setState(() {
              _weight = double.parse(weightController.text);
              _height = double.parse(heightController.text) / 100;
            });

            double imc = calculateIMC(_weight, _height);

            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  title: const Text('IMC'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Seu IMC é de ${imc.toStringAsFixed(2)}')
                      ],
                    )
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.15),
                  blurRadius: 40,
                  spreadRadius: 0.0
                )
              ]
            ),
            child: const Text(
              'Calculate',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
  }

  Container _inputField(String hintText, controller) {
    return Container(
          margin: const EdgeInsets.only(top: 50, right: 25, left: 25),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.15),
                blurRadius: 40,
                spreadRadius: 0.0
              )
            ]
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              )
            ),
          ),
        );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "IMC Calculator",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
