import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/common_widgets/custom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/custom_drop_down.dart';
import 'package:kw_express_pfe/common_widgets/custom_scaffold.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';

import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class InfoRestoForm extends StatefulWidget {
  const InfoRestoForm({
    Key? key,
    required this.resto,
    required this.onSaved,
  }) : super(key: key);
  final Restaurent resto;
  final void Function({
    required String username,
    required int wilaya,
    required String address,
    required String bio,
    required File? imageFile,
    required File? imageFile2,
  }) onSaved;

  @override
  _InfoRestoFormState createState() => _InfoRestoFormState();
}

class _InfoRestoFormState extends State<InfoRestoForm> {
  late String username;
  late int wilaya;
  late String address;
  late String bio;
  File? imageFile;
  File? imageFile2;
  late final GlobalKey<FormState> _formKey;
  bool isButtonEnabled = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
    username = widget.resto.name;
    wilaya = widget.resto.wilaya;
    address = widget.resto.address!;
    bio = widget.resto.bio!;
  }

  Future<void> pickImage(bool img) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      img ? imageFile = File(image.path) : imageFile2 = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(vertical: 1);
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            SignUpTitle(title: 'Informations de connexion'),
            SizedBox(height: 30),
            SignUpDivider(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 16.0,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => pickImage(true),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      image: imageFile != null
                                          ? DecorationImage(
                                              image: FileImage(imageFile!),
                                              //FileImage(imageFile!),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                widget.resto.profilePicture!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //     left: 8.0,
                                //     right: 8.0,
                                //     bottom: 16.0,
                                //   ),
                                //   child: Text('Photo de profile :'),
                                // ),
                                // Avatar(
                                //   placeHolder: Image.network(
                                //     widget.resto.profilePicture!,
                                //     width: 150,
                                //   ),
                                //   onChanged: (File f) {
                                //     imageFile = f;
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 16.0,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text('Photo de couverture :'),
                                ),
                                GestureDetector(
                                  onTap: () => pickImage(false),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      image: imageFile2 != null
                                          ? DecorationImage(
                                              image: FileImage(imageFile2!),
                                              //FileImage(imageFile!),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                widget.resto.couvPicture!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),

                                // Avatar(
                                //   placeHolder: Image.network(
                                //     widget.resto.couvPicture!,
                                //     width: 150,
                                //   ),
                                //   onChanged: (File f) {
                                //     imageFile2 = f;
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        initialValue: username,
                        fillColor: Colors.white70,
                        title: "Nom d'utilisateur:",
                        hintText: "Nom d'utilisateur...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          username = value;
                        },
                        validator: (String? value) {
                          if (!Validators.isValidUsername(value)) {
                            return invalidUsernameSignUpError;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomDropDown(
                        fillColor: Colors.white70,
                        title: 'Wilaya',
                        hint: wilaya.toString(),
                        validator: (String? value) {
                          if (value == null) {
                            return invalidWilayaError;
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          if (value == null) {
                          } else {
                            final int? wilayaN =
                                int.tryParse(value[0] + value[1]);

                            wilaya = wilayaN!;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        initialValue: address,
                        fillColor: Colors.white70,
                        title: "Adresse du restaurent:",
                        hintText: "Adresse du restaurent...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          address = value;
                        },
                        validator: (String? value) {
                          if (!Validators.isValidUsername(value)) {
                            return invalidUsernameSignUpError;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        initialValue: bio,
                        fillColor: Colors.white70,
                        title: "Bio:",
                        hintText: "Bio du restaurent...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          bio = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 20),
              child: Align(
                child: ButtomMedia(
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSaved(
                        username: username,
                        wilaya: wilaya,
                        bio: bio,
                        address: address,
                        imageFile: imageFile,
                        imageFile2: imageFile2,
                      );
                    }
                  },
                  color: Color(0xff5383EC),
                  text: 'Suivant',
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
