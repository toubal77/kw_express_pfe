import 'package:kw_express_pfe/app/models/user.dart';

class Restaurent extends User {
  Restaurent({
    required String id,
    required int type,
    required String name,
    required int remise,
    required String phoneNumber,
    required String? bio,
    required String? profilePicture,
    required String? couvPicture,
    required String? adress,
    required String? timeOpen,
    required String? mapAdress,
    required String? dure,
    required String createdBy,
    required bool isModerator,
    required bool isApproved,
    required int wilaya,
  }) : super(
          id: id,
          type: type,
          remise: remise,
          name: name,
          bio: bio,
          address: adress,
          timeOpen: timeOpen,
          mapAdress: mapAdress,
          dure: dure,
          isApproved: isApproved,
          couvPicture: couvPicture,
          profilePicture: profilePicture,
          phoneNumber: phoneNumber,
          createdBy: createdBy,
          isModerator: isModerator,
          wilaya: wilaya,
        );

  factory Restaurent.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final int remise = data['remise'] as int;
    final String name = data['name'] as String;
    final String? bio = data['bio'] as String?;
    final String phoneNumber = data['phoneNumber'] as String;
    final String? profilePicture = data['profilePicture'] as String?;
    final String? couvPicture = data['couvPicture'] as String?;
    final String? adress = data['address'] as String?;
    final String? timeOpen = data['timeOpen'] as String?;
    final String? mapAdress = data['mapAdress'] as String?;
    final String? dure = data['dure'] as String?;
    final String createdBy = data['createdBy'] as String;
    final bool isModerator = data['isModerator'] as bool;
    final bool isApproved = data['isApproved'] as bool;
    final int wilaya = data['wilaya'] as int;

    return Restaurent(
      id: id,
      type: type,
      name: name,
      remise: remise,
      bio: bio,
      phoneNumber: phoneNumber,
      couvPicture: couvPicture,
      profilePicture: profilePicture,
      adress: adress,
      timeOpen: timeOpen,
      mapAdress: mapAdress,
      dure: dure,
      createdBy: createdBy,
      isModerator: isModerator,
      isApproved: isApproved,
      wilaya: wilaya,
    );
  }
}
