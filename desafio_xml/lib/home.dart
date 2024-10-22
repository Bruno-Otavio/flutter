import 'package:desafio_xml/usuario_model.dart';
import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
