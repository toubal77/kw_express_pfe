import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_up/client/sign_up_client_screen.dart';
import 'package:kw_express_pfe/app/auth/sing_up/restaurent/sign_up_restaurent_screen.dart';
import 'package:kw_express_pfe/app/auth/sing_up/role_selector/role_selector_screen.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final PageController _pageController;
  Role? selectedRole;
  late Image userBackground;

  @override
  void initState() {
    _pageController = PageController();

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

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        RoleSelectorScreen(
          onNextPressed: (var role) {
            setState(() => selectedRole = role);

            swipePage(1);
          },
        ),
        if (selectedRole == Role.client) ...[
          SignUpClientScreen(),
        ],
        if (selectedRole == Role.restaurent) ...[
          SignUpRestaurentScreen(),
        ],
      ],
    );
  }
}
