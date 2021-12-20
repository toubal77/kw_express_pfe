import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_bloc.dart';
import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class AddCarouselSlider extends StatefulWidget {
  const AddCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCarouselSlider> createState() => _AddCarouselSliderState();
}

class _AddCarouselSliderState extends State<AddCarouselSlider> {
  File? imageFile;
  File? profilePicture;
  String? profilePictures;
  late String profilePictureUrl;
  late CarouselSliderBloc carouselSliderBloc;
  late final Auth auth;
  @override
  void initState() {
    auth = context.read<Auth>();
    final Database database = context.read<Database>();
    carouselSliderBloc = CarouselSliderBloc(
      database: database,
      currentUser: auth,
    );
    super.initState();
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 480);
    if (image != null) {
      imageFile = File(image.path);
      profilePicture = File(image.path);
      setState(() {});
    }
  }

  Future<void> sendCarouselSliderInfo() async {
    final Uuid uuid = Uuid();
    String carouselId = uuid.v4();

    if (profilePicture != null) {
      profilePictureUrl = await carouselSliderBloc.uploadProductProfileImage(
        profilePicture!,
        carouselId,
      );
    }
    try {
      final ProgressDialog pd = ProgressDialog(context: context);

      final CarouselSlideModel carouselSlider = CarouselSlideModel(
        id: carouselId,
        pictureUrl: profilePictureUrl,
        createdBy: auth.currentUser()!.uid,
        createdAt: Timestamp.now(),
      );
      await carouselSliderBloc.saveCarouselSliderInfo(carouselSlider);
      pd.close();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(exception: e).show(context);
    }
  }

  Widget buildUploadButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: pickImage,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          minimumSize: MaterialStateProperty.all(Size(200, 70)),
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Télécharger des images',
              style: TextStyle(
                color: Color.fromRGBO(51, 77, 115, 0.88),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                Icons.file_upload,
                color: Color.fromRGBO(51, 77, 115, 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhoto() {
    return GestureDetector(
      onTap: pickImage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: imageFile != null
            ? Image.memory(imageFile!.readAsBytesSync())
            : CachedNetworkImage(imageUrl: profilePictures!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
            child: Text(
              "Image principale du produit\nVeuillez choisir une image horizontale ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(34, 50, 99, 1),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (imageFile == null && profilePictures == null)
            Align(child: buildUploadButton()),
          if (!(imageFile == null && profilePictures == null))
            Align(child: SizedBox(child: buildPhoto())),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 20),
              child: ButtomMedia(
                press: sendCarouselSliderInfo,
                color: Color(0xff5383EC),
                text: 'Suivant',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
