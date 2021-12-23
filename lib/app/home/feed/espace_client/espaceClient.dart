import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:kw_express_pfe/app/home/feed/espace_client/serviceClient.dart';
import 'package:kw_express_pfe/app/home/feed/espace_client/widget/build_espace_client.dart';
import 'package:url_launcher/url_launcher.dart';

class EspaceClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Espace Client',
          style: TextStyle(
            color: Colors.grey,
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
                          //   IconsApp.questions,
                          Icons.question_answer,
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
                          //  IconsApp.noteApp,
                          Icons.note_add,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var linkUrl = 'https://www.facebook.com/KWAffichage/';
                if (await canLaunch(linkUrl.toString())) {
                  await launch(
                    linkUrl.toString(),
                  );
                }
              },
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'powerdBy',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'CedarvilleCursive-Regular',
                        color: Colors.red,
                      ),
                    ),
                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   child: SvgPicture.asset(iconKWsvg),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
