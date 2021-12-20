import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_logout.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class RestaurentMenu extends StatefulWidget {
  const RestaurentMenu({Key? key}) : super(key: key);

  @override
  _RestaurentMenuState createState() => _RestaurentMenuState();
}

class _RestaurentMenuState extends State<RestaurentMenu> {
  late Stream<List<Restaurent>> unapprovedUsers;

  late final RestaurentBloc bloc;

  @override
  void initState() {
    final User user = context.read<User>();
    final Database database = context.read<Database>();
    bloc = RestaurentBloc(
      database: database,
      currentUser: user,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: Text('hhhhh'),
        ),
      ),
      //  StreamBuilder<List<Restaurent>>(
      //   stream: unapprovedUsers,
      //   builder: (context, snapshot) {
      //     return Scaffold(
      //       appBar: AppBar(
      //         backgroundColor: Colors.white,
      //         centerTitle: true,
      //         actions: [RestaurentLogout()],
      //         iconTheme: IconThemeData(color: darkBlue),
      //         title: Text(
      //           'Menu',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //         leading: Padding(
      //           padding: const EdgeInsets.only(left: 8.0),
      //           child: IconButton(
      //             icon: Icon(
      //               Icons.add,
      //               size: 25,
      //             ),
      //             color: darkBlue,
      //             onPressed: () {
      //               // logger.info(usersList.length);
      //               // if (usersList.isNotEmpty) {
      //               //   showSearch(
      //               //     context: context,
      //               //     delegate: ApproveSearch(
      //               //       approvedBloc: bloc,
      //               //       users: usersList,
      //               //     ),
      //               //   );
      //               // }
      //             },
      //           ),
      //         ),
      //       ),
      //       // body: buildBody(snapshot),
      //     );
      //   },
      // ),
    );
  }

  Widget buildBody(AsyncSnapshot<List<Restaurent>> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      // final List<User> items = snapshot.data!;
      // usersList = items;
      bool i = false;
      // ignore: dead_code
      if (i) {
        // if (items.isNotEmpty) {
        //   return ListView.builder(
        //     itemCount: items.length,
        //     itemBuilder: (_, index) {
        //       return ApprovedUserTile(
        //         user: items[index],
        //         bloc: bloc,
        //       );
        //     },
        //   );
        print('godhg');
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: EmptyContent(
            title: 'Aucun message ne suit les personnes pour commencer',
            message: '',
          ),
        );
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: "Quelque chose s'est mal passé",
        message: "Impossible de charger les éléments pour le moment",
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
