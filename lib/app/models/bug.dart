class Bug {
  Bug({
    required this.id,
    required this.type,
    required this.name,
    required this.phoneNumber,
    required this.description,
  });

  final String id;
  final String type;
  final String name;
  final String phoneNumber;
  final String description;

  factory Bug.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;

    final String name = data['name'] as String;
    final String type = data['type'] as String;
    final String phoneNumber = data['phoneNumber'] as String;
    final String description = data['description'] as String;

    return Bug(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      description: description,
      type: type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'phoneNumber': phoneNumber,
      'description': description,
    };
  }
}
