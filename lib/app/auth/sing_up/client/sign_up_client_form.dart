import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/custom_drop_down.dart';
import 'package:kw_express_pfe/common_widgets/custom_elevated_button.dart';
import 'package:kw_express_pfe/common_widgets/custom_scaffold.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class SignUpClientForm extends StatefulWidget {
  const SignUpClientForm({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String username,
    required int wilaya,
    required String password,
    required String phoneNumber,
  }) onSaved;

  @override
  _SignUpClientFormState createState() => _SignUpClientFormState();
}

class _SignUpClientFormState extends State<SignUpClientForm> {
  late String username;
  late int wilaya;
  late String password;
  late String phoneNumber;

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
                            //! TODO low fix this wierd string concat bitch
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
              padding: const EdgeInsets.only(right: 30.0, top: 20),
              child: Align(
                alignment: Alignment.center,
                child: ButtomMedia(
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSaved(
                        username: username,
                        wilaya: wilaya,
                        password: password,
                        phoneNumber: phoneNumber,
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
