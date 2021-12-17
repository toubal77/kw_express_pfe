import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sign_in/sing_in_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return SingInScreen();
  }
}
