import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/approved/approved_screen.dart';
import 'package:kw_express_pfe/app/home_admin/bugs/bug_screen.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_screen.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/moderators_screen.dart';
import 'package:kw_express_pfe/app/models/admin.dart';
import 'package:kw_express_pfe/common_widgets/fab_bottom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late final Admin admin;
  int index = 0;
  late List<Widget> screens;

  @override
  void initState() {
    admin = context.read<Admin>();
    super.initState();
    screens = [
      ModeratorsScreen(),
      CarsouselSliderScreen(),
      ApprovedScreen(),
      BugScreen(),
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
          selectedColor: iconBackgroundColor,
          notchedShape: CircularNotchedRectangle(),
          selectedIndex: index,
          onTabSelected: (int index) {
            setState(() => this.index = index);
          },
          items: [
            FABBottomAppBarItem(iconData: Icons.people, notification: 0),
            FABBottomAppBarItem(
                iconData: Icons.picture_in_picture, notification: 0),
            FABBottomAppBarItem(iconData: Icons.restaurant, notification: 0),
            FABBottomAppBarItem(iconData: Icons.bug_report, notification: 0),
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
