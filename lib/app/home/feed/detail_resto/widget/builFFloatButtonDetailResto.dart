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
          if (await canLaunch(resDet.mapAdress.toString())) {
            await launch(
              resDet.mapAdress.toString(),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Can\'t open google map'),
              ),
            );
          }
        },
        () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Reserver une table:"),
                    content: GestureDetector(
                      onTap: () {
                        launch('tel:${resDet.phoneNumber.toString()}');
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
                              launch('tel:${resDet.phoneNumber}');
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
                          GestureDetector(
                            onTap: () {
                              launch('tel:${resDet.phoneNumber}');
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
