class Categorias {
  String id;
  String title;

  Categorias({
    required this.id,
    required this.title,
  });

  factory Categorias.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Categorias(
      id: documentId,
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
