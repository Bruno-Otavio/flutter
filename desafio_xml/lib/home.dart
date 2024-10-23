import 'dart:io';
import 'dart:math';

import 'package:desafio_xml/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Usuario>> _loadData() async {
    final file =
        await DefaultAssetBundle.of(context).loadString('assets/usuarios.xml');
    final document = xml.XmlDocument.parse(file);

    final usuarios = document.findAllElements('usuario');

    return usuarios
        .map(
          (e) => Usuario(
            id: e.findElements('id').first.innerText,
            nome: e.findElements('nome').first.innerText,
            email: e.findElements('email').first.innerText,
            senha: e.findElements('senha').first.innerText,
          ),
        )
        .toList();
  }

  void _add() async {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();

    final file =
        await DefaultAssetBundle.of(context).loadString('assets/usuarios.xml');
    final document = xml.XmlDocument.parse(file);

    final builder = xml.XmlBuilder();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: controller1),
              TextField(controller: controller2),
              TextField(controller: controller3),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                builder.processing('xml', 'version="1.0"');
                builder.element('usuario', nest: () {
                  builder.element('id', nest: Random().nextInt(100));
                  builder.element('nome', nest: controller1.text);
                  builder.element('email', nest: controller2.text);
                  builder.element('senha', nest: controller3.text);
                });

                final completeDocument = builder.buildDocument();
                document.children.add(completeDocument.rootElement.copy());
              },
              child: const Text('Confirmar'),
            ),
            ElevatedButton(onPressed: () => _export(document), child: const Text('Exportar')),
          ],
        );
      },
    );
  }

  void _export(document) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/usuarios.xml');
    file.writeAsString(document.toString());
    print(directory.path);
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = _loadData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio XML'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.blue,
              size: 100,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: usuarios,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final Usuario user = data[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.person, size: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.nome),
                                Text(user.email),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          ElevatedButton(onPressed: _add, child: const Text('Adicionar')),
        ],
      ),
    );
  }
}
