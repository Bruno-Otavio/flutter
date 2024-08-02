import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CREATE: add a new note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStrema() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();

    return noteStream;
  }

  // UPDATE: update notes from database given a doc id
  Future<void> updateNote(String id, String newNote) {
    return notes.doc(id).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes from database given a doc id
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }
}
