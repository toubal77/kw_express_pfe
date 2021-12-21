class TypeMenu {
  TypeMenu({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory TypeMenu.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;

    final String name = data['name'] as String;

    return TypeMenu(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
