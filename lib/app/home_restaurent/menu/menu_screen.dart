import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_logout.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class RestaurentMenu extends StatefulWidget {
  const RestaurentMenu({Key? key}) : super(key: key);

  @override
  _RestaurentMenuState createState() => _RestaurentMenuState();
}

class _RestaurentMenuState extends State<RestaurentMenu> {
  late Stream<Restaurent?> restaurent;

  late final RestaurentBloc bloc;

  @override
  void initState() {
    final User user = context.read<User>();
    final Database database = context.read<Database>();
    late TabController tabController;
    bloc = RestaurentBloc(
      database: database,
      currentUser: user,
    );
    restaurent = bloc.getMyResto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: StreamBuilder<Restaurent?>(
        stream: restaurent,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: [RestaurentLogout()],
              iconTheme: IconThemeData(color: darkBlue),
              title: Text(
                'Mon Restaurent',
                style: TextStyle(color: Colors.black),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 25,
                  ),
                  color: darkBlue,
                  onPressed: () {
                    // logger.info(usersList.length);
                    // if (usersList.isNotEmpty) {
                    //   showSearch(
                    //     context: context,
                    //     delegate: ApproveSearch(
                    //       approvedBloc: bloc,
                    //       users: usersList,
                    //     ),
                    //   );
                    // }
                  },
                ),
              ),
            ),
            body: buildBody(snapshot),
          );
        },
      ),
    );
  }

  Widget buildBody(AsyncSnapshot<Restaurent?> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final Restaurent resto = snapshot.data!;
      return SizedBox(
        height: SizeConfig.screenHeight,
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    resto.couvPicture!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(color: Colors.white, width: 5.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            resto.profilePicture!,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        child: Text(
                          resto.bio!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  DefaultTabController(
                    length: 5,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.red,
                      indicatorWeight: 2.0,
                      tabs: <Widget>[
                        for (int i = 0; i < 5; i++)
                          Tab(
                            child: Container(
                              child: Text(
                                'pizza',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (!(snapshot.hasData && snapshot.data != null)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: EmptyContent(
          title: 'Aucun message ne suit les personnes pour commencer',
          message: '',
        ),
      );
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: "Quelque chose s'est mal passé",
        message: "Impossible de charger les éléments pour le moment",
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
