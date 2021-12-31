import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:kw_express_pfe/app/models/client.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';

import 'package:uuid/uuid.dart';

class SignUpBloc {
  SignUpBloc({
    required this.auth,
    required this.database,
  });
  final Auth auth;
  final Database database;
  final Uuid uuid = Uuid();

  String? verificationId;
  late AuthUser _authUser;

  Future<String> uploadProfilePicture(File file) async {
    return database.uploadFile(
      path: APIPath.userProfilePicture(_authUser.uid, uuid.v4()),
      filePath: file.path,
    );
  }

  Future<String> uploadCouvPicture(File file) async {
    return database.uploadFile(
      path: APIPath.userCouvPicture(_authUser.uid, uuid.v4()),
      filePath: file.path,
    );
  }

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

  Future<bool> magic(
    String username,
    String password,
    String phoneCode,
  ) async {
    // throws if the code has not been sent yet
    if (verificationId == null) {
      throw firebase_auth.FirebaseAuthException(
        code: 'CODE_NOT_SENT_YET',
        message: "le code de vérification n'a pas encore été envoyé",
      );
    }
    final String email = '$username@randolina-10bf4.firebaseapp.com';

    // sign in the user with email/password
    final AuthUser? authUser = auth.currentUser();
    if (authUser == null) {
      await auth.signUpWithEmailAndPassword(
        email,
        password,
      );
    }
    // verify phone number and link phone to the user
    await auth.linkUserPhoneNumber(phoneCode, verificationId!);
    final AuthUser? user = auth.currentUser();
    if (user == null) {
      return false;
    } else {
      _authUser = user;
      return true;
    }
  }

  Future<void> saveClientInfo(Client client) async {
    final Client clientt = Client(
      id: '',
      type: 1,
      name: client.name,
      address: '',
      bio: '',
      profilePicture: '',
      couvPicture: '',
      phoneNumber: client.phoneNumber,
      createdBy: _authUser.uid,
      isModerator: false,
      isApproved: true,
      wilaya: client.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(_authUser.uid),
      data: clientt.toMap(),
      merge: false,
    );
  }

  Future<void> saveRestaurentInfo(Restaurent restaurent) async {
    final Restaurent restaurentt = Restaurent(
      id: '',
      type: 2,
      name: restaurent.name,
      bio: restaurent.bio,
      phoneNumber: restaurent.phoneNumber,
      couvPicture: restaurent.couvPicture,
      profilePicture: restaurent.profilePicture,
      adress: restaurent.address,
      createdBy: _authUser.uid,
      isModerator: false,
      isApproved: false,
      wilaya: restaurent.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(_authUser.uid),
      data: restaurentt.toMap(),
      merge: false,
    );
  }
}
