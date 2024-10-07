import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime date;
  String? categoryId; // Añadir categoría opcional

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.categoryId, // categoria 
  
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      categoryId: data['categoryId'] ?? '', // ----
  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'categoryId': categoryId,
    };
  }

  int daysSinceCreation() {
    final currentDate = DateTime.now();
    return currentDate.difference(date).inDays;
  }
}
