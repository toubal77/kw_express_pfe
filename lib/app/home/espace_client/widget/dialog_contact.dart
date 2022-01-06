import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

dialogContact(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Contacte K&W Express :"),
        content: Container(
          height: 300,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  launch('tel:+213${659185831}');
                },
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/drawable/phone.svg'),
                  ),
                  title: Text(
                    'Telephone',
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
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/drawable/facebook.svg'),
                  ),
                  title: Text(
                    'Facebook',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var linkUrl =
                      'https://www.facebook.com/KWExpressDZ/?hc_ref=ARQw6jFYllcpJSaLlKTi2oChmbv_rdIk2B65vVWEb6g6I0KvY6xZeB_PWAFdtkf8Lcc&fref=nf&__tn__=kC-R';
                  if (await canLaunch(linkUrl.toString())) {
                    await launch(
                      linkUrl.toString(),
                    );
                  }
                },
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/drawable/messenger.svg'),
                  ),
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
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/drawable/viber.svg'),
                  ),
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
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/drawable/gmail.svg'),
                  ),
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
}
