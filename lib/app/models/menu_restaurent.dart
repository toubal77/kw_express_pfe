class MenuRestaurent {
  MenuRestaurent({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.prix,
  });

  final String id;
  final String type;
  final String name;
  final String description;
  final double prix;

  factory MenuRestaurent.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final String type = data['type'] as String;
    final String name = data['name'] as String;
    final String description = data['description'] as String;
    final double prix = data['prix'] as double;
    return MenuRestaurent(
      id: id,
      type: type,
      name: name,
      description: description,
      prix: prix,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'prix': prix,
    };
  }
}
