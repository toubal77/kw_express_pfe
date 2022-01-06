import 'package:flutter/material.dart';
import 'package:kw_express_pfe/common_widgets/icons_app.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kw_express_pfe/app/models/restaurent.dart';

class BuildFloatButtonDetailResto extends StatelessWidget {
  final Restaurent resDet;
  BuildFloatButtonDetailResto(this.resDet);
  @override
  Widget build(BuildContext context) {
    return SpeedDialFabWidget(
      secondaryIconsList: [
        IconsApp.trouve,
        IconsApp.reserver,
        IconsApp.commande,
      ],
      secondaryIconsText: [
        "Trouver",
        "Reserver",
        "Commander",
      ],
      secondaryIconsOnPress: [
        () async {
          // if (await canLaunch(resDet!.map.toString())) {
          //   await launch(
          //     resDet!.map.toString(),
          //   );
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Can\'t open google map'),
          //     ),
          //   );
          // }
        },
        () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Reserver une table:"),
                    content: GestureDetector(
                      onTap: () {
                        launch('tel:+213${resDet.phoneNumber.toString()}');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.blue,
                        ),
                        title: Text(
                          resDet.phoneNumber,
                        ),
                      ),
                    ),
                  );
                },
              )
            },
        () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Passer votre commande:"),
                    content: Container(
                      height: 120,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              launch('tel:+213${0542149642}');
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.call,
                                color: Colors.blue,
                              ),
                              title: Text(
                                '0659185831',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launch('tel:+213${0792140427}');
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.call,
                                color: Colors.blue,
                              ),
                              title: Text(
                                '0792140427',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            },
      ],
      primaryIconExpand: IconsApp.floatButton,
      secondaryBackgroundColor: Colors.red,
      secondaryForegroundColor: Colors.white,
      primaryBackgroundColor: Colors.red,
      primaryForegroundColor: Colors.white,
    );
  }
}
