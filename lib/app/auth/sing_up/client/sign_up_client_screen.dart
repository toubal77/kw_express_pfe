import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_up/client/sign_up_client_form.dart';
import 'package:kw_express_pfe/app/auth/sing_up/sign_up_bloc.dart';
import 'package:kw_express_pfe/app/auth/sing_up/sign_up_phone_confirmation.dart';
import 'package:kw_express_pfe/app/home/home_screen.dart';
import 'package:kw_express_pfe/app/models/client.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:provider/provider.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';

class SignUpClientScreen extends StatefulWidget {
  const SignUpClientScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpClientScreenState createState() => _SignUpClientScreenState();
}

class _SignUpClientScreenState extends State<SignUpClientScreen> {
  late final PageController _pageController;
  late SignUpBloc bloc;
  late String _fullname;
  late String _username;
  late int _wilaya;
  late String _password;
  late String _phoneNumber;
  late File _imageFile;
  String? _bio;
  late String _activity;
  late Timestamp _dateOfBirth;

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

  Future<void> sendClientInfo() async {
    // start loading widget
    try {
      final ProgressDialog pd = ProgressDialog(context: context);

      final Client store = Client(
        id: '',
        type: 1,
        name: _username,
        phoneNumber: _phoneNumber,
        isModerator: false,
        wilaya: _wilaya,
      );
      await bloc.saveClientInfo(store);
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
            SignUpClientForm(
              onSaved: ({
                required String password,
                required String phoneNumber,
                required String username,
                required int wilaya,
              }) async {
                try {
                  _password = password;
                  _phoneNumber = phoneNumber;
                  _username = username;
                  _wilaya = wilaya;

                  await bloc.verifyPhoneNumber(_phoneNumber);
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
                    _username,
                    _password,
                    code,
                  );
                  if (isLoggedIn) {
                    // swipePage(2);
                    sendClientInfo();
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
