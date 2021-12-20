import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/home_screen.dart';
import 'package:kw_express_pfe/app/home_admin/admin_home.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_home.dart';
import 'package:kw_express_pfe/app/models/admin.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/loading_screen.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final Stream userstram;

  @override
  void initState() {
    final AuthUser authUser = context.read<AuthUser>();
    final Database database = context.read<Database>();
    userstram = database.streamDocument(
      path: APIPath.userDocument(authUser.uid),
      builder: (data, documentId) {
        // if (data.containsKey('isAdmin')) {
        if (data['isModerator'] == true) {
          return Admin.fromMap(data, documentId);
        }
        return User.fromMap2(data, documentId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userstram,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && (snapshot.data != null)) {
          if (snapshot.data! is Admin) {
            final Admin admin = snapshot.data! as Admin;

            return Provider<User>.value(
              value: admin,
              child: Provider.value(
                value: admin,
                child: WillPopScope(
                  onWillPop: () async {
                    final bool a = !await navigatorKey.currentState!.maybePop();
                    return a;
                  },
                  child: Navigator(
                    key: navigatorKey,
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) => AdminHome(),
                        //  builder: (context) => HomeScreen(),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          if (snapshot.data! is User) {
            final User user = snapshot.data! as User;
            logger.info('current user ${user.id}');
            return Provider<User>.value(
              value: user,
              child: Provider.value(
                value: user,
                child: WillPopScope(
                  onWillPop: () async {
                    final bool a = !await navigatorKey.currentState!.maybePop();
                    return a;
                  },
                  child: Navigator(
                    key: navigatorKey,
                    onGenerateRoute: (routeSettings) {
                      if (user.type == 1) {
                        return MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        );
                      }
                      if (user.type == 2) {
                        return MaterialPageRoute(
                          builder: (context) => RestaurentHome(),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Material(
            child: EmptyContent(
              title: '',
              message: snapshot.error.toString(),
            ),
          );
        }
        return LoadingScreen(showAppBar: false);
      },
    );
  }
}
