import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';

class SignInForm2 extends StatefulWidget {
  const SignInForm2({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String address,
  }) onSaved;
  @override
  State<SignInForm2> createState() => _SignInForm2State();
}

class _SignInForm2State extends State<SignInForm2> {
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
      print('lalitude: ${position.latitude}, logitude: ${position.latitude}');

      final Address address = await geoCode.reverseGeocoding(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      print("Street Number: ${address.streetNumber}");
      print("Street Address: ${address.streetAddress}");
      print("City: ${address.city}");
      print("Region: ${address.region}");
      print("code Postal: ${address.postal}");
      print("Country Name: ${address.countryName}");
      print('eàzhg $address');
      adressUser =
          '${address.streetNumber} ${address.streetAddress} ${address.city} ${address.region} ${address.postal} ${address.countryName}';
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
      resizeToAvoidBottomInset: false,
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
                  padding: const EdgeInsets.only(top: 20, left: 24.95),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 246.w,
                        height: 29.h,
                        child: Text(
                          'Select Your Location',
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
                          "Swithch on your location to stay in tune with what's happening in your area",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff7C7C7C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (getLocation)
                        SizedBox(
                          width: 324.w,
                          height: 57.h,
                          child: Text(
                            'Your adress: $adressUser',
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
                        ButtomMedia(
                          press: () {
                            if (getLocation == true) {
                              widget.onSaved(
                                address: adressUser,
                              );
                            } else {
                              getUserLocation();
                            }
                          },
                          color: Color(0xff5383EC),
                          text: !getLocation ? 'Get Location' : 'Submit',
                        ),
                      const SizedBox(
                        height: 15,
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
