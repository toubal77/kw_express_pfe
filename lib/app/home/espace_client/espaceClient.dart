import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:kw_express_pfe/app/home/espace_client/my_order/my_order_screen.dart';
import 'package:kw_express_pfe/app/home/espace_client/serviceClient.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/build_espace_client.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/build_power_by.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/icons_app.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/firebase_messaging_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class EspaceClient extends StatelessWidget {
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MyOrderScreen();
                          }),
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'Mes commandes',
                        icon: Icon(
                          IconsApp.serviceClient,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FlutterShare.share(
                          title: 'K&W Express',
                          text: '',
                          linkUrl:
                              'https://play.google.com/store/apps/details?id=com.kwexpress.app',
                          chooserTitle: 'Partager',
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'inviter vos amis',
                        icon: Icon(
                          IconsApp.share,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ServiceClient();
                          }),
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'Service Client',
                        icon: Icon(
                          IconsApp.serviceClient,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ServiceClient();
                          }),
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'Questions Frequentes',
                        icon: Icon(
                          IconsApp.questions,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var linkUrl =
                            'https://play.google.com/store/apps/details?id=com.kwexpress.app';
                        if (await canLaunch(linkUrl.toString())) {
                          await launch(
                            linkUrl.toString(),
                          );
                        }
                      },
                      child: BuildEspaceClient(
                        title: 'Noter L\'application',
                        icon: Icon(
                          IconsApp.noteApp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        final Auth auth = context.read<Auth>();
                        final User user = context.read<User>();
                        auth.signOut();
                        context
                            .read<FirebaseMessagingService>()
                            .removeToken(user.id);
                      },
                      child: BuildEspaceClient(
                        title: 'Log out',
                        icon: Icon(
                          IconsApp.questions,
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
