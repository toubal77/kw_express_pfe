import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/app/auth/widgets/background_image.dart';

class SelectLocation extends StatefulWidget {
  final bool arrow;
  const SelectLocation({Key? key, required this.arrow}) : super(key: key);
  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  bool getLocation = false;
  bool isLoading = false;
  late String adressUser;
  getUserLocation() async {
    GeoCode geoCode = GeoCode();
    setState(() {
      isLoading = true;
    });
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lastPosition = await Geolocator.getLastKnownPosition();
      print(lastPosition);
      print('lalitude: ${position.latitude}, logitude: ${position.latitude}');

      Address address = await geoCode.reverseGeocoding(
          latitude: position.latitude, longitude: position.longitude);
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44FFFEFE),
        leading: widget.arrow
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Platform.isIOS
                    ? Icon(Icons.arrow_back_ios)
                    : Icon(Icons.arrow_back),
                color: Color(0xff181725),
              )
            : null,
        elevation: 0,
      ),
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
                      top: 133, left: 94.66, right: 94.66),
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
                      getLocation
                          ? SizedBox(
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
                          : SizedBox(),
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: CircularProgressIndicator(),
                            )
                          : TextButton(
                              onPressed: () {
                                if (getLocation == true) {
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return const HomeWidget();
                                  //     },
                                  //   ),
                                  // );
                                } else {
                                  getUserLocation();
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 25, left: 25.3, right: 24.52),
                                width: 364.w,
                                height: 67.h,
                                decoration: BoxDecoration(
                                  color: Color(0xff53B175),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Center(
                                  child: Text(
                                    !getLocation ? 'Get Location' : 'Submit',
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
