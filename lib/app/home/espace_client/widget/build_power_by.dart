import 'package:flutter/material.dart';

import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildPowerBy extends StatelessWidget {
  const BuildPowerBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            Container(
              width: 100,
              height: 100,
              child: Image.asset(iconKWpng),
              //  child: SvgPicture.asset(iconKWsvg),
            ),
          ],
        ),
      ),
    );
  }
}
