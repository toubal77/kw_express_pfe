import 'package:kw_express_pfe/app/models/user.dart';

class Admin extends User {
  Admin({
    required String id,
  }) : super(
          id: id,
          type: 0,
          remise: 0,
          name: 'name',
          bio: '',
          address: '',
          timeOpen: '',
          mapAdress: '',
          dure: '',
          profilePicture: '',
          couvPicture: '',
          phoneNumber: '0',
          createdBy: '',
          isModerator: false,
          isApproved: false,
          wilaya: 31,
        );

  // ignore: avoid_unused_constructor_parameters
  factory Admin.fromMap(Map<String, dynamic> data, String documentId) {
    return Admin(
      id: documentId,
    );
  }
}
