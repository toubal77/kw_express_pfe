import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_in/sing_in_form.dart';
import 'package:kw_express_pfe/app/auth/sing_in/sing_in_form2.dart';
import 'package:kw_express_pfe/app/home/home_screen.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  //late final SignUpBloc bloc;
  late final PageController _pageController;

  late bool loginPhone;
  late String phoneNumber;
  late String adressUser;

  @override
  void initState() {
    _pageController = PageController();
    // final Auth auth = context.read<Auth>();
    // final Database database = context.read<Database>();
    // bloc = SignUpBloc(auth: auth, database: database);

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
    Navigator.of(context)
      ..pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
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
              email = email;
              password = password;
              swipePage(1);
            },
          ),
          SignInForm2(
            onSaved: ({
              required String address,
            }) {
              adressUser = address;
              sendInfoLogin();
            },
          ),
        ],
      ),
    );
  }
}
