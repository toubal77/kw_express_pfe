import 'package:kw_express_pfe/app/models/restaurent.dart';

class User {
  User({
    required this.id,
    required this.type,
    required this.name,
    required this.remise,
    required this.bio,
    required this.profilePicture,
    required this.couvPicture,
    required this.phoneNumber,
    required this.address,
    required this.timeOpen,
    required this.mapAdress,
    required this.dure,
    required this.createdBy,
    required this.isApproved,
    required this.isModerator,
    required this.wilaya,
  });

  //type 0 admin
  //type 1 client
  //type 2 restaurent
  final String id;
  final int type;
  final int remise;
  final String name;
  final String? bio;
  final String? address;
  final String? profilePicture;
  final String? couvPicture;
  final String? timeOpen;
  final String? mapAdress;
  final String? dure;
  final String phoneNumber;
  final String createdBy;
  final bool isApproved;
  final bool isModerator;
  final int wilaya;

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;
    final int type = data['type'] as int;
    final int remise = data['remise'] as int;
    final String name = data['name'] as String;
    final String? bio = data['bio'] as String?;
    final String? address = data['address'] as String?;
    final String? timeOpen = data['timeOpen'] as String?;
    final String? mapAdress = data['mapAdress'] as String?;
    final String? dure = data['dure'] as String?;
    final String phoneNumber = data['phoneNumber'] as String;
    final String? profilePicture = data['profilePicture'] as String?;
    final String? couvPicture = data['couvPicture'] as String?;
    final String createdBy = data['createdBy'] as String;
    final bool isModerator = data['isModerator'] as bool;
    final bool isApproved = data['isApproved'] as bool;
    final int wilaya = data['wilaya'] as int;
    return User(
      id: id,
      type: type,
      remise: remise,
      name: name,
      bio: bio,
      address: address,
      timeOpen: timeOpen,
      mapAdress: mapAdress,
      dure: dure,
      profilePicture: profilePicture,
      couvPicture: couvPicture,
      phoneNumber: phoneNumber,
      createdBy: createdBy,
      isModerator: isModerator,
      isApproved: isApproved,
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
      'remise': remise,
      'name': name,
      'bio': bio,
      'address': address,
      'timeOpen': timeOpen,
      'mapAdress': mapAdress,
      'dure': dure,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'couvPicture': couvPicture,
      'createdBy': createdBy,
      'isModerator': isModerator,
      'isApproved': isApproved,
      'wilaya': wilaya,
    };
  }
}
