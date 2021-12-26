import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/espace_resto_screen.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/menu_screen.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/fab_bottom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:provider/provider.dart';

class RestaurentHome extends StatefulWidget {
  const RestaurentHome({Key? key}) : super(key: key);

  @override
  _RestaurentHomeState createState() => _RestaurentHomeState();
}

class _RestaurentHomeState extends State<RestaurentHome> {
  late final User admin;
  int index = 1;
  late List<Widget> screens;

  @override
  void initState() {
    admin = context.read<User>();
    super.initState();
    screens = [
      RestaurentMenu(),
      RestaurentMenu(),
      EspaceResto(),
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
          buildCenterSpace: false,
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
            FABBottomAppBarItem(iconData: Icons.menu_book, notification: 0),
            FABBottomAppBarItem(iconData: Icons.restaurant, notification: 0),
            FABBottomAppBarItem(
                iconData: Icons.account_circle, notification: 0),
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
