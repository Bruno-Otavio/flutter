import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE: add a new note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get notes from database

  // UPDATE: update notes from database given a doc id

  // DELETE: delete notes from database given a doc id
}