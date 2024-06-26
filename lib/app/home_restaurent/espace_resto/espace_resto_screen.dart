import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/build_power_by.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/info_resto/info_resto_screen.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/update_phone/update_phone_screen.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/widgets/build_espace_resto.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/widgets/build_offre.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EspaceResto extends StatefulWidget {
  @override
  _EspaceRestoState createState() => _EspaceRestoState();
}

class _EspaceRestoState extends State<EspaceResto> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Espace Client',
          style: TextStyle(
            color: iconBackgroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 6.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return InfoRestoScreen();
                            },
                          ),
                        );
                      },
                      child: BuildEspaceResto(
                        title: 'Modifier les Informations du resto',
                        icon: Icon(
                          //  IconsApp.share,
                          Icons.share, color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdatePhoneScreen();
                            },
                          ),
                        );
                      },
                      child: BuildEspaceResto(
                        title: 'Modifier le numero de telephone',
                        icon: Icon(
                          //      IconsApp.serviceClient,
                          Icons.room_service,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('tel:+213659185831');
                      },
                      child: BuildEspaceResto(
                        title: 'Appeler l\'administrateur',
                        icon: Icon(
                          //      IconsApp.serviceClient,
                          Icons.call_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await buildOffre(context, bloc);
                      },
                      child: BuildEspaceResto(
                        title: 'Faire un offre',
                        icon: Icon(
                          //  IconsApp.share,
                          Icons.offline_share, color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        bloc.desctiveResto();
                        Fluttertoast.showToast(
                          msg: 'Votre restaurent est desctive avec succès',
                          toastLength: Toast.LENGTH_LONG,
                        );
                      },
                      child: BuildEspaceResto(
                        title: 'Desctive mon Restaurent',
                        icon: Icon(
                          //   IconsApp.questions,
                          Icons.no_accounts_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        bloc.sendRequest();
                      },
                      child: BuildEspaceResto(
                        title: 'Demande l\'activation de mon restaurent',
                        icon: Icon(
                          //   IconsApp.questions,
                          Icons.manage_accounts_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<Auth>().signOut();
                      },
                      child: BuildEspaceResto(
                        title: 'Log out',
                        icon: Icon(
                          //   IconsApp.questions,
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BuildPowerBy(),
          ],
        ),
      ),
    );
  }
}
