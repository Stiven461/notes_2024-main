class Responsable {
  String id;
  String name;

  Responsable({
    required this.id,
    required this.name,
  });

  factory Responsable.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return Responsable(
      id: documentId,
      name: data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
