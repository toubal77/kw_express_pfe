import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/sing_in/singin_screen.dart';
import 'package:kw_express_pfe/app/base_screen.dart';
import 'package:kw_express_pfe/app/home/home_screen.dart';
import 'package:kw_express_pfe/common_widgets/loading_screen.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final Auth auth = context.read<Auth>();
    return SingInScreen();
    // return StreamBuilder<AuthUser?>(
    //   stream: auth.onAuthStateChanged,
    //   builder: (context, authSnapshot) {
    //     if (authSnapshot.connectionState == ConnectionState.active) {
    //       final AuthUser? user = authSnapshot.data;

    //       if (user == null) {
    //         return SingInScreen();
    //       } else {
    //         Navigator.of(context)
    //             .pushReplacement(MaterialPageRoute(builder: (context) {
    //           return HomeScreen();
    //         }));
    //       }
    //       // return Provider.value(
    //       //   value: user,
    //       //   child: BaseScreen(),
    //       // );
    //     }
    //     return LoadingScreen();
    //   },
    // );
  }
}
