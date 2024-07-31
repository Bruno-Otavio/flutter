import 'package:firebase_crud/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _noteController = TextEditingController();

  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _noteController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_noteController.text == '') {
                return;
              }
              
              firestoreService.addNote(_noteController.text);
              _noteController.clear();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
    );
  }
}
