import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class EspaceRestoBloc {
  EspaceRestoBloc({
    required this.database,
    required this.auth,
  });

  final Database database;
  final Auth auth;

  String? verificationId;
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      /// fires automatically if the app reads the sms
      verificationCompleted: (firebase_auth.PhoneAuthCredential credential) {
        logger.warning('****automatic verification');
      },

      /// firebase auth returned an error
      onVerificationFailed: (firebase_auth.FirebaseAuthException e) {
        throw e;
      },

      /// When Firebase sends an SMS code to the device, this handler is triggered
      /// Once triggered, it would be a good time to update your application UI
      /// to prompt the user to enter the SMS code they're expecting/
      onCodeSent: (String verificationId2, int? resendToken) {
        verificationId = verificationId2;
        logger.info('****codeSent: $verificationId');
        // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
      },
    );
  }

  Future<void> sendInfo(String phoneNumber, String code, context) async {
    final firebase_auth.AuthCredential credential =
        firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: code,
    );
    final firebase_auth.User currentUser = context.read<User>();
    currentUser.linkWithCredential(credential);
    final User user = context.read<User>();
    final Restaurent restaurentt = Restaurent(
      id: user.id,
      type: 2,
      remise: user.remise,
      name: user.name,
      bio: user.bio,
      timeOpen: user.timeOpen,
      mapAdress: user.mapAdress,
      dure: user.dure,
      phoneNumber: phoneNumber,
      couvPicture: user.couvPicture,
      profilePicture: user.profilePicture,
      adress: user.address,
      createdBy: user.createdBy,
      isModerator: false,
      isApproved: user.isApproved,
      wilaya: user.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(user.id),
      data: restaurentt.toMap(),
      merge: false,
    );
  }
}
