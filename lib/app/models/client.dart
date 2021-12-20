import 'package:kw_express_pfe/app/models/user.dart';

class Client extends User {
  Client({
    required String id,
    required int type,
    required String name,
    required String? address,
    required String phoneNumber,
    required bool isModerator,
    required bool isApproved,
    required int wilaya,
  }) : super(
          id: id,
          type: type,
          name: name,
          address: address,
          phoneNumber: phoneNumber,
          isApproved: isApproved,
          isModerator: isModerator,
          wilaya: wilaya,
        );

  factory Client.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final String name = data['name'] as String;
    final String? address = data['address'] as String?;
    final String phoneNumber = data['phoneNumber'] as String;
    final bool isModerator = data['isModerator'] as bool;
    final bool isApproved = data['isApproved'] as bool;
    final int wilaya = data['wilaya'] as int;

    return Client(
      id: id,
      type: type,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      isApproved: isApproved,
      isModerator: isModerator,
      wilaya: wilaya,
    );
  }
}
