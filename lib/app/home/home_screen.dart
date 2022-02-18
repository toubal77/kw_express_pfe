import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/espace_client/espaceClient.dart';
import 'package:kw_express_pfe/app/home/favorites/favoriteResto.dart';
import 'package:kw_express_pfe/app/home/feed/feed_screen.dart';
import 'package:kw_express_pfe/app/home/offer_resto/offreResto.dart';
import 'package:kw_express_pfe/common_widgets/fab_bottom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late final User user;
  int index = 1;
  late List<Widget> screens;

  @override
  void initState() {
    //  user = context.read<User>();
    // final Database database = context.read<Database>();
    super.initState();
    // final FirebaseMessagingService firebaseMessagingService =
    //     FirebaseMessagingService();
    // firebaseMessagingService.configFirebaseNotification(user.id, database);
    screens = [
      FeedScreen(),
      OffreResto(),
      EspaceClient(),
      // ProfileScreen(user: user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return WillPopScope(
      onWillPop: () async {
        if (index == 0) {
          return true;
        } else {
          setState(() {
            index = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        body: IndexedStack(index: index, children: screens),
        bottomNavigationBar: FABBottomAppBar(
          height: 55,
          iconSize: 32,
          centerItemText: '',
          color: Colors.grey,
          selectedColor: darkBlue,
          notchedShape: CircularNotchedRectangle(),
          selectedIndex: index,
          onTabSelected: (int index) {
            setState(() => this.index = index);
          },
          items: [
            FABBottomAppBarItem(iconData: Icons.home, notification: 0),
            //  FABBottomAppBarItem(iconData: Icons.store, notification: 0),
            FABBottomAppBarItem(
              iconData: Icons.calendar_today,
              notification: 0,
            ),
            FABBottomAppBarItem(
              iconData: Icons.account_circle_outlined,
              notification: 0,
            ),
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
