import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String notesCollection = 'notes';

  // Obtener todas las notas
  Future<List<Note>> getNotes() async {
    QuerySnapshot querySnapshot = await _firestore.collection('notes').get();
    return querySnapshot.docs.map((doc) {
      return Note.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Agregar una nueva nota
  Future<void> addNote(Note note) async {
    await _firestore.collection(notesCollection).add(note.toMap());
  }

  // Actualizar una nota existente
  Future<void> updateNote(Note note) async {
    await _firestore
        .collection(notesCollection)
        .doc(note.id)
        .update(note.toMap());
  }

  // Eliminar una nota
  Future<void> deleteNote(String noteId) async {
    await _firestore.collection(notesCollection).doc(noteId).delete();
  }
}
