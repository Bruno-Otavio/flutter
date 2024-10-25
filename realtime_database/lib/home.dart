import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _carsReference =
      FirebaseDatabase.instance.ref().child('carros');

  final TextEditingController _carController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final DatabaseReference _carReference =
      FirebaseDatabase.instance.ref('carros');

  void _add() {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _carReference.child(id).set({
      'id': id,
      'nome': _carController.text,
      'price': _priceController.text,
    });

    _carController.text = '';
    _priceController.text = '';

    Navigator.pop(context);
  }

  void _delete(String id) {
    _carsReference.child(id).remove();
  }

  void _update(String id) {
    _carsReference.child(id).update({
      'id': id,
      'nome': _carController.text,
      'price': _priceController.text,
    });

    Navigator.pop(context);

    _carController.text = '';
    _priceController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Time Database')),
      body: FirebaseAnimatedList(
        query: _carsReference,
        itemBuilder: (context, snapshot, animation, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(snapshot.child('nome').value.toString()),
              subtitle: Text(snapshot.child('price').value.toString()),
              trailing: IconButton(
                onPressed: () => _delete(
                  snapshot.child('id').value.toString(),
                ),
                icon: const Icon(Icons.remove),
              ),
              leading: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(controller: _carController),
                            TextField(controller: _priceController),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => _update(
                              snapshot.child('id').value.toString(),
                            ),
                            child: const Text('update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: _carController),
                    TextField(controller: _priceController),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: _add,
                    child: const Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
