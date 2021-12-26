import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/cart/cartScreen.dart';
import 'package:kw_express_pfe/app/home/feed/feed_bloc.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/widget/build_couv_resto.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/widget/build_detail_resto_menu.dart';
import 'package:kw_express_pfe/app/home_restaurent/menu/widget/build_profile_bio_menu_resto.dart';
import 'package:kw_express_pfe/app/models/cart.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/types_menu.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

String? type;

class DetailRestoScreen extends StatefulWidget {
  const DetailRestoScreen({
    Key? key,
    required this.resto,
  }) : super(key: key);
  final Restaurent resto;
  @override
  _DetailRestoScreenState createState() => _DetailRestoScreenState();
}

class _DetailRestoScreenState extends State<DetailRestoScreen> {
  late Stream<List<MenuRestaurent?>> menuResto;
  late Stream<List<TypeMenu?>> typesMenu;

  late final FeedBloc bloc;

  @override
  void initState() {
    final User user = context.read<User>();
    final Database database = context.read<Database>();
    bloc = FeedBloc(
      database: database,
      currentUser: user,
    );
    menuResto = bloc.getMenuResto(widget.resto.createdBy);
    typesMenu = bloc.getTypesMenu(widget.resto.createdBy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          //  actions: [RestaurentLogout()],
          iconTheme: IconThemeData(color: darkBlue),
          title: Text(
            'Mon Restaurent',
            style: TextStyle(color: Colors.black),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            BuildCouvResto(resto: widget.resto),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: StreamBuilder<List<TypeMenu?>>(
                stream: typesMenu,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<TypeMenu?> typeMenu = snapshot.data!;
                    return DefaultTabController(
                      length: typeMenu.length,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red,
                        indicatorWeight: 2.0,
                        tabs: <Widget>[
                          for (int i = 0; i < typeMenu.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  type = typeMenu[i]!.name;
                                  print('fdohsdogh $type');
                                });
                              },
                              child: Tab(
                                child: Container(
                                  child: Text(
                                    typeMenu[i]!.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                    ),
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
            ),
            Expanded(
              child: StreamBuilder<List<MenuRestaurent?>>(
                stream: menuResto,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<MenuRestaurent?> menuResto = snapshot.data!;
                    return ListView.builder(
                      itemCount: menuResto.length,
                      itemBuilder: (context, index) {
                        return type == menuResto[index]!.type
                            ? BuildDetailRestoMenu(res: menuResto[index]!)
                            : Container();
                      },
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
            ),
          ],
        ),
        Positioned(
          top: 110,
          left: 25,
          child: BuildProfileBioResto(resto: widget.resto),
        ),
        if (Provider.of<Cart>(context, listen: false).itemEmpty == true)
          Positioned(
            bottom: 20,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(widget.resto.name),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'VOIR PANIER',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
