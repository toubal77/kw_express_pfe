import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_up/restaurent/sign_up_restaurent_form.dart';
import 'package:kw_express_pfe/app/auth/sing_up/sign_up_bloc.dart';
import 'package:kw_express_pfe/app/auth/sing_up/sign_up_phone_confirmation.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:provider/provider.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';

class SignUpRestaurentScreen extends StatefulWidget {
  const SignUpRestaurentScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpRestaurentScreenState createState() => _SignUpRestaurentScreenState();
}

class _SignUpRestaurentScreenState extends State<SignUpRestaurentScreen> {
  late final PageController _pageController;
  late final SignUpBloc bloc;
  late String usernames;
  late int wilayaa;
  late String passwords;
  late String addresss;
  late String bioo;
  late String phoneNumberr;
  late File? imageFilee;
  late File? imageFilee2;

  @override
  void initState() {
    _pageController = PageController();
    final Auth auth = context.read<Auth>();
    final Database database = context.read<Database>();
    bloc = SignUpBloc(auth: auth, database: database);

    super.initState();
  }

  void swipePage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> sendRestaurentInfo() async {
    final String profilePictureUrl =
        await bloc.uploadProfilePicture(imageFilee!);
    final String couvPicture = await bloc.uploadCouvPicture(imageFilee2!);
    try {
      final ProgressDialog pd = ProgressDialog(context: context);

      final Restaurent restaurent = Restaurent(
        id: '',
        type: 2,
        name: usernames,
        bio: bioo,
        phoneNumber: phoneNumberr,
        couvPicture: couvPicture,
        profilePicture: profilePictureUrl,
        adress: addresss,
        isModerator: false,
        isApproved: false,
        wilaya: wilayaa,
      );
      await bloc.saveRestaurentInfo(restaurent);
      pd.close();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(exception: e).show(context);
    }
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    //   return HomeScreen();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.hasClients) {
          if (_pageController.page == 0) {
            return true;
          } else {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
        return false;
      },
      child: SizedBox(
        height: SizeConfig.screenHeight,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            SignUpRestaurentForm(
              onSaved: ({
                required String password,
                required String phoneNumber,
                required String username,
                required String address,
                required String bio,
                required int wilaya,
                required File? imageFile,
                required File? imageFile2,
              }) async {
                try {
                  passwords = password;
                  phoneNumberr = phoneNumber;
                  usernames = username;
                  addresss = address;
                  bioo = bio;
                  wilayaa = wilaya;
                  imageFilee = imageFile;
                  imageFilee2 = imageFile2;
                  await bloc.verifyPhoneNumber(phoneNumber);
                  swipePage(1);
                } on Exception catch (e) {
                  logger.severe('Error in verifyPhoneNumber');
                  PlatformExceptionAlertDialog(exception: e).show(context);
                }
              },
            ),
            SignUpPhoneConfirmation(
              onNextPressed: (String code) async {
                try {
                  final bool isLoggedIn = await bloc.magic(
                    usernames,
                    passwords,
                    code,
                  );
                  if (isLoggedIn) {
                    sendRestaurentInfo();
                  }
                } on Exception catch (e) {
                  PlatformExceptionAlertDialog(exception: e).show(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
