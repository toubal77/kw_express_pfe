import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';

class EspaceRestoBloc {
  EspaceRestoBloc({
    required this.database,
    required this.currentUser,
  });

  final Database database;
  final User currentUser;

  String? verificationId;
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final Restaurent restaurentt = Restaurent(
      id: currentUser.id,
      type: 2,
      remise: currentUser.remise,
      name: currentUser.name,
      bio: currentUser.bio,
      timeOpen: currentUser.timeOpen,
      mapAdress: currentUser.mapAdress,
      dure: currentUser.dure,
      phoneNumber: phoneNumber,
      couvPicture: currentUser.couvPicture,
      profilePicture: currentUser.profilePicture,
      adress: currentUser.address,
      createdBy: currentUser.createdBy,
      isModerator: false,
      isApproved: currentUser.isApproved,
      wilaya: currentUser.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(currentUser.id),
      data: restaurentt.toMap(),
      merge: false,
    );
  }
}
