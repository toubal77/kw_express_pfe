import 'package:kw_express_pfe/app/models/mini_user.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';

class User {
  User({
    required this.id,
    required this.type,
    required this.name,
    required this.phoneNumber,
    required this.isModerator,
    required this.wilaya,
  });

  //type 0 admin
  //type 1 client
  //type 2 restaurent
  final String id;
  final int type;
  final String name;
  final String phoneNumber;
  final bool isModerator;
  final int wilaya;

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final String name = data['name'] as String;
    final String phoneNumber = data['phoneNumber'] as String;
    final bool isModerator = data['isModerator'] as bool;
    final int wilaya = data['wilaya'] as int;
    return User(
      id: id,
      type: type,
      name: name,
      phoneNumber: phoneNumber,
      isModerator: isModerator,
      wilaya: wilaya,
    );
  }

  factory User.fromMap2(Map<String, dynamic> data, String documentId) {
    final int type = data['type'] as int;
    if (type == 0) {
      return Restaurent.fromMap(data, documentId);
    }
    return User.fromMap(data, documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'phoneNumber': phoneNumber,
      'wilaya': wilaya,
    };
  }

  MiniUser toMiniUser() {
    return MiniUser(
      id: id,
      name: name,
    );
  }
}
