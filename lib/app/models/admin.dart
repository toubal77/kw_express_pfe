import 'package:kw_express_pfe/app/models/user.dart';

class Admin extends User {
  Admin({
    required String id,
  }) : super(
          id: id,
          type: 0,
          name: 'name',
          phoneNumber: '0',
          isModerator: false,
          wilaya: 31,
        );

  // ignore: avoid_unused_constructor_parameters
  factory Admin.fromMap(Map<String, dynamic> data, String documentId) {
    return Admin(
      id: documentId,
    );
  }
}
