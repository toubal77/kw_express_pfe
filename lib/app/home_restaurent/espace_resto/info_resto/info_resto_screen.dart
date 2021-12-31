import 'dart:io';

import 'package:flutter/material.dart';

import 'package:kw_express_pfe/app/home_restaurent/espace_resto/info_resto/info_resto_form.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';

class InfoRestoScreen extends StatefulWidget {
  const InfoRestoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InfoRestoScreenState createState() => _InfoRestoScreenState();
}

class _InfoRestoScreenState extends State<InfoRestoScreen> {
  late final PageController _pageController;
  late final RestaurentBloc bloc;
  late String usernames;
  late int wilayaa;

  late String addresss;
  late String bioo;
  late File? imageFilee;
  late File? imageFilee2;
  late User user;
  late Restaurent restos;
  @override
  void initState() {
    _pageController = PageController();
    user = context.read<User>();

    final Database database = context.read<Database>();
    bloc = RestaurentBloc(
      database: database,
      currentUser: user,
    );
    restos = Restaurent(
      id: user.id,
      type: 2,
      name: user.name,
      bio: user.bio,
      phoneNumber: user.phoneNumber,
      couvPicture: user.couvPicture,
      profilePicture: user.profilePicture,
      adress: user.address,
      createdBy: user.id,
      isModerator: false,
      isApproved: false,
      wilaya: user.wilaya,
    );
    super.initState();
  }

  void swipePage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> sendRestaurentInfo() async {
    late String profilePictureUrl = '';
    late String couvPicture = '';
    if (imageFilee != null) {
      profilePictureUrl = await bloc.uploadProfilePicture(imageFilee!);
    }
    if (imageFilee2 != null) {
      couvPicture = await bloc.uploadCouvPicture(imageFilee2!);
    }
    try {
      final ProgressDialog pd = ProgressDialog(context: context);

      final Restaurent restaurent = Restaurent(
        id: user.id,
        type: 2,
        name: usernames,
        bio: bioo,
        phoneNumber: user.phoneNumber,
        couvPicture: couvPicture == '' ? user.couvPicture : couvPicture,
        profilePicture:
            profilePictureUrl == '' ? user.profilePicture : profilePictureUrl,
        adress: addresss,
        createdBy: user.id,
        isModerator: false,
        isApproved: false,
        wilaya: wilayaa,
      );
      await bloc.saveRestaurentInfo(restaurent);
      pd.close();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(exception: e).show(context);
    }
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    //   return HomeScreen();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.hasClients) {
          if (_pageController.page == 0) {
            return true;
          } else {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
        return false;
      },
      child: SizedBox(
        height: SizeConfig.screenHeight,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            InfoRestoForm(
              resto: restos,
              onSaved: ({
                required String username,
                required String address,
                required String bio,
                required int wilaya,
                required File? imageFile,
                required File? imageFile2,
              }) {
                usernames = username;
                addresss = address;
                bioo = bio;
                wilayaa = wilaya;
                imageFilee = imageFile;
                imageFilee2 = imageFile2;

                sendRestaurentInfo();
                swipePage(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
