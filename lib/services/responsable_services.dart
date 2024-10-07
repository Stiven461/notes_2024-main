import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resposanble_model.dart';

class ResponsableService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String notesCollection = 'responsable';

  // Listar Responsables
  Future<List<Responsable>> getResponsable() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('responsable').get();
    return querySnapshot.docs.map((doc) {
      return Responsable.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Adicionar Responsables
  Future<void> addResponsable(Responsable responsable) async {
    await _firestore.collection(notesCollection).add(responsable.toMap());
  }
}
