import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/widget/build_couv_resto.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/widget/build_profile_bio_menu_resto.dart';
import 'package:kw_express_pfe/app/home_restaurent/new_menu/new_menu_screen.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_logout.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
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
  late Stream<List<MenuRestaurent?>> menuResto;

  late final RestaurentBloc bloc;

  @override
  void initState() {
    final User user = context.read<User>();
    final Database database = context.read<Database>();
    bloc = RestaurentBloc(
      database: database,
      currentUser: user,
    );
    restaurent = bloc.getMyResto();
    menuResto = bloc.getMenuResto();
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NewMenuScreen();
                    }));
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
            BuildCouvResto(resto: resto),
            Positioned(
              top: 110,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildProfileBioResto(resto: resto),
                  StreamBuilder<List<MenuRestaurent?>>(
                    stream: menuResto,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final List<MenuRestaurent?> menuResto = snapshot.data!;
                        return DefaultTabController(
                          length: menuResto.length,
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.red,
                            indicatorWeight: 2.0,
                            tabs: <Widget>[
                              for (int i = 0; i < menuResto.length; i++)
                                Tab(
                                  child: Container(
                                    child: Text(
                                      menuResto[i]!.type,
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
                        );
                      } else if (!(snapshot.hasData && snapshot.data != null)) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EmptyContent(
                            title: 'Aucune Données',
                            message: '',
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return EmptyContent(
                          title: "Quelque chose s'est mal passé",
                          message:
                              "Impossible de charger les éléments pour le moment",
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
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
