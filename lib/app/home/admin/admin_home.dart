import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/admin/approved/approved_screen.dart';
import 'package:kw_express_pfe/app/home/admin/carousel_slider/carousel_slider.dart';
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
  int index = 4;
  late List<Widget> screens;

  @override
  void initState() {
    admin = context.read<Admin>();
    super.initState();
    screens = [
      AddImages(),
      AddImages(),
      AddImages(),
      ApprovedScreen(),
      AddImages(),
      // ModeratorsScreen(),
      // SitesScreen(),
      // ReportedPostsScreen(),
      // ApprovedScreen(),
      // SubScreen(),
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
            FABBottomAppBarItem(iconData: Icons.people, notification: 0),
            FABBottomAppBarItem(iconData: Icons.gps_fixed, notification: 0),
            FABBottomAppBarItem(iconData: Icons.report, notification: 0),
            FABBottomAppBarItem(iconData: Icons.report, notification: 0),
            FABBottomAppBarItem(
                iconData: Icons.account_circle_outlined, notification: 0),
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:kw_express_pfe/app/home/admin/carousel_slider/carousel_slider.dart';
// import 'package:kw_express_pfe/services/firebase_auth.dart';

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             TextButton(
//               onPressed: () {
//                // FirebaseAuthService().signOut();
//                     context.read<Auth>().signOut();
//               },
//               child: Text('Sing out'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return AddImages();
//                     },
//                   ),
//                 );
//               },
//               child: Text('Add images'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
