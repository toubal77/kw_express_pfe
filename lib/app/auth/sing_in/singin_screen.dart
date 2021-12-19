import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_in/sign_in_bloc.dart';
import 'package:kw_express_pfe/app/auth/sing_in/sing_in_form.dart';
import 'package:kw_express_pfe/app/home/home_screen.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:provider/src/provider.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  late final SignInBloc bloc;
  late final PageController _pageController;

  late String passwords;
  late String usernames;
  late String adressUser;

  @override
  void initState() {
    _pageController = PageController();
    final Auth auth = context.read<Auth>();

    bloc = SignInBloc(auth: auth);

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

  Future<void> sendInfoLogin() async {
    try {
      await bloc.signIn(usernames, passwords);
      Navigator.of(context)
        ..pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(exception: e).show(context);
    }
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
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          SignInForm(
            onSaved: ({
              required String email,
              required String password,
            }) {
              usernames = email;
              passwords = password;
              //    swipePage(1);
              sendInfoLogin();
            },
          ),
          // SignInForm2(
          //   onSaved: ({
          //     required String address,
          //   }) {
          //     adressUser = address;
          //     sendInfoLogin();
          //   },
          // ),
        ],
      ),
    );
  }
}
