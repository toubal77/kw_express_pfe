import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/avatar.dart';
import 'package:kw_express_pfe/common_widgets/custom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/custom_drop_down.dart';
import 'package:kw_express_pfe/common_widgets/custom_scaffold.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class SignUpRestaurentForm extends StatefulWidget {
  const SignUpRestaurentForm({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String username,
    required int wilaya,
    required String password,
    required String address,
    required String timeOpen,
    required String mapAdress,
    required String dure,
    required String bio,
    required String phoneNumber,
    required File? imageFile,
    required File? imageFile2,
  }) onSaved;

  @override
  _SignUpRestaurentFormState createState() => _SignUpRestaurentFormState();
}

class _SignUpRestaurentFormState extends State<SignUpRestaurentForm> {
  late String username;
  late int wilaya;
  late String password;
  late String phoneNumber;
  late String address;
  late String timeOpen;
  late String mapAdress;
  late String dure;
  late String bio;
  File? imageFile;
  File? imageFile2;
  late final GlobalKey<FormState> _formKey;
  bool isButtonEnabled = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text('Photo de profile :'),
                                ),
                                Avatar(
                                  placeHolder: Image.asset(
                                    uploadPicture,
                                    width: 150,
                                  ),
                                  onChanged: (File f) {
                                    imageFile = f;
                                  },
                                ),
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
                                Avatar(
                                  placeHolder: Image.asset(
                                    uploadPicture,
                                    width: 150,
                                  ),
                                  onChanged: (File f) {
                                    imageFile2 = f;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
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
                        hint: 'Wilaya',
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
                        fillColor: Colors.white70,
                        title: 'Mot de passe:',
                        hintText: 'Mot de passe...',
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        onChanged: (var t) {
                          password = t;
                        },
                        validator: (String? value) {
                          if (!Validators.isValidPassword(value)) {
                            return invalidPasswordError;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
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
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Heure d'ouverture:",
                        hintText: "exemple 8h-17h...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          timeOpen = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Adresse google map:",
                        hintText:
                            "https://www.google.com/maps/place/Cit%C3%A9+Sabbah...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          mapAdress = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Dure de preparation:",
                        hintText: "exemple 20min-30min...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          dure = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: 'Numéro de téléphone:',
                        maxLength: 10,
                        isPhoneNumber: true,
                        onChanged: (var value) {
                          phoneNumber = value;
                          phoneNumber =
                              phoneNumber.replaceFirst(RegExp('0'), '');
                          phoneNumber = '+213$phoneNumber';
                        },
                        prefix: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '+213',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 57,
                                child: VerticalDivider(
                                  thickness: 1,
                                  width: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || !value.startsWith('0')) {
                            return invalidPhoneNumberError;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                child: ButtomMedia(
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSaved(
                        username: username,
                        wilaya: wilaya,
                        bio: bio,
                        timeOpen: timeOpen,
                        mapAdress: mapAdress,
                        dure: dure,
                        password: password,
                        address: address,
                        phoneNumber: phoneNumber,
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
