import 'package:kw_express_pfe/app/models/user.dart';

class Restaurent extends User {
  Restaurent({
    required String id,
    required int type,
    required String name,
    required String phoneNumber,
    required String? adress,
    required bool isModerator,
    required bool isApproved,
    required int wilaya,
  }) : super(
          id: id,
          type: type,
          name: name,
          address: adress,
          isApproved: isApproved,
          phoneNumber: phoneNumber,
          isModerator: isModerator,
          wilaya: wilaya,
        );

  factory Restaurent.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final String name = data['name'] as String;
    final String phoneNumber = data['phoneNumber'] as String;
    final String? adress = data['address'] as String?;
    final bool isModerator = data['isModerator'] as bool;
    final bool isApproved = data['isApproved'] as bool;
    final int wilaya = data['wilaya'] as int;

    return Restaurent(
      id: id,
      type: type,
      name: name,
      phoneNumber: phoneNumber,
      adress: adress,
      isModerator: isModerator,
      isApproved: isApproved,
      wilaya: wilaya,
    );
  }
}
