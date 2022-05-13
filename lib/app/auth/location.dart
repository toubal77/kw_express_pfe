import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kw_express_pfe/app/landing_screen.dart';
import 'package:kw_express_pfe/constants/algeria_cities.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({
    Key? key,
  }) : super(key: key);
  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  bool getLocation = false;
  bool isLoading = false;
  late String adressUser;
  // ignore: always_declare_return_types, type_annotate_public_apis
  getUserLocation() async {
    final GeoCode geoCode = GeoCode();
    setState(() {
      isLoading = true;
    });
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final lastPosition = await Geolocator.getLastKnownPosition();
      print(lastPosition);
      print('lalitude: ${position.longitude}, logitude: ${position.latitude}');
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print('dosghi $placemarks');
      // final Address address = await geoCode.reverseGeocoding(
      //   latitude: position.latitude,
      //   longitude: position.longitude,
      // );
      print("Street Address: ${placemarks[0].street}");
      print("City: ${placemarks[0].administrativeArea}");
      print("Region: ${placemarks[0].subAdministrativeArea}");
      print("code Postal: ${placemarks[0].postalCode}");
      print("Country Name: ${placemarks[0].country}");
      //  var wilayaCode = placemarks[0].postalCode!.substring(0, 2).toUpperCase();
      var wilayaCode;
      for (int i = 0; i < algeriaCities.length; i++) {
        if (algeriaCities[i]['daira_name_ascii'] ==
            placemarks[0].subAdministrativeArea) {
          wilayaCode = algeriaCities[i]['wilaya_code'];
          print(algeriaCities[i]['wilaya_code']);
        }
      }
      adressUser =
          '${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].subAdministrativeArea} ${placemarks[0].postalCode} $wilayaCode ${placemarks[0].country}';
      print(adressUser);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs
          .setString('wilaya', wilayaCode)
          .then((value) => print('done done done'));
      setState(() {
        getLocation = true;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Color(0x44FFFEFE),
      //   leading: widget.arrow
      //       ? IconButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           icon: Platform.isIOS
      //               ? Icon(Icons.arrow_back_ios)
      //               : Icon(Icons.arrow_back),
      //           color: Color(0xff181725),
      //         )
      //       : null,
      //   elevation: 0,
      // ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          //     Positioned(child: BackgroundImage()),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 224.69.w,
                  height: 170.69.h,
                  margin: const EdgeInsets.only(
                    top: 133,
                    left: 94.66,
                    right: 94.66,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(whiteLogo),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25, right: 23),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 246.w,
                        height: 50.h,
                        child: Text(
                          'Sélectionnez votre emplacement',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff191725),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15.18,
                      ),
                      SizedBox(
                        width: 324.w,
                        height: 57.h,
                        child: Text(
                          "Activez votre position pour rester en contact avec les restaurants dans votre région",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff7C7C7C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (getLocation)
                        SizedBox(
                          width: 364.w,
                          height: 67.h,
                          child: Text(
                            'Votre adresse: $adressUser',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff7C7C7C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        SizedBox(),
                      if (isLoading)
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: CircularProgressIndicator(),
                        )
                      else
                        TextButton(
                          onPressed: () {
                            if (getLocation == true) {
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return const HomeWidget();
                              //     },
                              //   ),
                              // );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandingScreen(),
                                ),
                              );
                            } else {
                              getUserLocation();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 23, right: 23),
                            width: 364.w,
                            height: 67.h,
                            decoration: BoxDecoration(
                              color: Color(0xff53B175),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Center(
                              child: Text(
                                !getLocation
                                    ? 'Obtenir l\'emplacement'
                                    : 'Soumettre',
                                style: TextStyle(
                                  color: Color(0xffFFF9FF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
