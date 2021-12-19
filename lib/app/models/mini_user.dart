class MiniUser {
  MiniUser({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory MiniUser.fromMap(Map<String, dynamic> data) {
    final String id = data['id'] as String;

    final String name = data['name'] as String;

    return MiniUser(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
