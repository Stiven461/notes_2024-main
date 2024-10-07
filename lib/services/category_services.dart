import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notes_2024/models/category.dart';

class CategoriasServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String notesCollection = 'categorias';

  // Obtener todas las notas
  Future<List<Categorias>> getCategorias() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('categorias').get();
    return querySnapshot.docs.map((doc) {
      return Categorias.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Agregar una nueva nota
  Future<void> addCategorias(Categorias categorias) async {
    await _firestore.collection(notesCollection).add(categorias.toMap());
  }
}
