import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/feed/espace_client/widget/build_espace_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceClient extends StatelessWidget {
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
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Reserver une table:"),
                              content: Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        launch('tel:+213${659185831}');
                                      },
                                      child: ListTile(
                                        // leading: Container(
                                        //   width: 30,
                                        //   height: 30,
                                        //   child: SvgPicture.asset(
                                        //       'assets/drawer/phone.svg'),

                                        // ),
                                        leading: Icon(Icons.cabin),
                                        title: Text(
                                          'Telephone',
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var linkUrl =
                                            'https://www.facebook.com/KWAffichage/';
                                        if (await canLaunch(
                                            linkUrl.toString())) {
                                          await launch(
                                            linkUrl.toString(),
                                          );
                                        }
                                      },
                                      child: ListTile(
                                        // leading: Container(
                                        //   width: 30,
                                        //   height: 30,
                                        //   child: SvgPicture.asset(
                                        //       'assets/drawer/facebook.svg'),
                                        // ),
                                        leading: Icon(Icons.cabin),
                                        title: Text(
                                          'Facebook',
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var linkUrl =
                                            'https://www.facebook.com/KWExpressDZ/?hc_ref=ARQw6jFYllcpJSaLlKTi2oChmbv_rdIk2B65vVWEb6g6I0KvY6xZeB_PWAFdtkf8Lcc&fref=nf&__tn__=kC-R';
                                        if (await canLaunch(
                                            linkUrl.toString())) {
                                          await launch(
                                            linkUrl.toString(),
                                          );
                                        }
                                      },
                                      child: ListTile(
                                        // leading: Container(
                                        //   width: 30,
                                        //   height: 30,
                                        //   child: SvgPicture.asset(
                                        //       'assets/drawer/messenger.svg'),
                                        // ),
                                        leading: Icon(Icons.cabin),
                                        title: Text(
                                          'Messenger',
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch('tel:+213${659185831}');
                                      },
                                      child: ListTile(
                                        // leading: Container(
                                        //   width: 30,
                                        //   height: 30,
                                        //   child: SvgPicture.asset(
                                        //       'assets/drawer/viber.svg'),
                                        // ),
                                        leading: Icon(Icons.cabin),
                                        title: Text(
                                          'Viber',
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Email email = Email(
                                          to: ['kw.entreprise.dz@gmail.com'],
                                        );
                                        await EmailLauncher.launch(email);
                                      },
                                      child: ListTile(
                                        // leading: Container(
                                        //   width: 30,
                                        //   height: 30,
                                        //   child: SvgPicture.asset(
                                        //       'assets/drawer/gmail.svg'),
                                        // ),
                                        leading: Icon(Icons.cabin),
                                        title: Text(
                                          'Gmail',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'Contact Direct',
                        icon: Icon(
                          //     IconsApp.contact,
                          Icons.contact_page,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        TextEditingController _nameResto =
                            TextEditingController();
                        TextEditingController _numClient =
                            TextEditingController();
                        TextEditingController _addressResto =
                            TextEditingController();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Remplissez les champs ci-dessous"),
                              content: Container(
                                height: 250,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _nameResto,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Nom du restaurant",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                      onSubmitted: (val) {
                                        _nameResto.text = val.trim();
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: _numClient,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Numero du telephone",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                      onSubmitted: (val) {
                                        _numClient.text = val.trim();
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: _addressResto,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "address du restaurant",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                      onSubmitted: (val) {
                                        _addressResto.text = val.trim();
                                      },
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // DatabaseMethodes().sendMessage(
                                        //     _nameResto.text,
                                        //     _numClient.text,
                                        //     _addressResto.text);
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ENVOYER',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: BuildEspaceClient(
                        title: 'Nouveau Restaurant',
                        icon: Icon(
                          //      IconsApp.resto,
                          Icons.restaurant,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Bug',
                        icon: Icon(
                          //               IconsApp.bug,
                          Icons.bug_report,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Reclamation',
                        icon: Icon(
                          // IconsApp.recla,
                          Icons.recommend_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Nouveau Restaurant',
                        icon: Icon(
                          //         IconsApp.sugg,
                          Icons.support_agent,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
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
                  //   child: SvgPicture.asset(kwSvg),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
