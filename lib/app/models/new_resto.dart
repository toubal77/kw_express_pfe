class NewResto {
  NewResto({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  final String id;

  final String name;
  final String phoneNumber;
  final String address;

  factory NewResto.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;

    final String name = data['name'] as String;

    final String phoneNumber = data['phoneNumber'] as String;
    final String address = data['address'] as String;

    return NewResto(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
