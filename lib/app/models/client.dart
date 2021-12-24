import 'package:kw_express_pfe/app/models/user.dart';

class Client extends User {
  Client({
    required String id,
    required int type,
    required String name,
    required String? bio,
    required String? address,
    required String? profilePicture,
    required String? couvPicture,
    required String phoneNumber,
    required String createdBy,
    required bool isModerator,
    required bool isApproved,
    required int wilaya,
  }) : super(
          id: id,
          type: type,
          name: name,
          bio: bio,
          address: address,
          phoneNumber: phoneNumber,
          couvPicture: couvPicture,
          profilePicture: profilePicture,
          createdBy: createdBy,
          isApproved: isApproved,
          isModerator: isModerator,
          wilaya: wilaya,
        );

  factory Client.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final String name = data['name'] as String;
    final String? bio = data['bio'] as String?;
    final String? address = data['address'] as String?;
    final String? profilePicture = data['profilePicture'] as String?;
    final String? couvPicture = data['couvPicture'] as String?;
    final String phoneNumber = data['phoneNumber'] as String;
    final String createdBy = data['createdBy'] as String;
    final bool isModerator = data['isModerator'] as bool;
    final bool isApproved = data['isApproved'] as bool;
    final int wilaya = data['wilaya'] as int;

    return Client(
      id: id,
      type: type,
      name: name,
      bio: bio,
      address: address,
      profilePicture: profilePicture,
      couvPicture: couvPicture,
      phoneNumber: phoneNumber,
      createdBy: createdBy,
      isApproved: isApproved,
      isModerator: isModerator,
      wilaya: wilaya,
    );
  }
}
