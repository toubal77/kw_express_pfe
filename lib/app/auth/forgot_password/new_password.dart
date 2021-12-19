import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    Key? key,
    required this.onNextPressed,
  }) : super(key: key);
  final ValueChanged<String> onNextPressed;

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  String? password1;
  String? password2;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  Widget _buildSignInButton() {
    return ButtomMedia(
      press: () {
        if (_formKey.currentState!.validate()) {
          if (password1 != null && password2 != null) {
            if (password1 != password2) {
              PlatformExceptionAlertDialog(
                exception: PlatformException(
                  code: 'PASSWORDS_DOES_NOT_MATCH',
                  message:
                      'les deux mots de passe ne correspondent pas, veuillez réécrire votre mot de passe',
                ),
              ).show(context);
            } else {
              widget.onNextPressed(password1!);
            }
          }
        }
      },
      color: Color(0xff5383EC),
      text: 'Sauvegarder',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SizedBox(
          height: SizeConfig.screenHeight + 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    whiteLogo,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Entrez votre nouveau mot de passe',
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextForm(
                      title: 'nouveau mot de passe:',
                      titleStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontSize: 16,
                      ),
                      hintText: 'mot de passe...',
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (var t) {
                        password1 = t;
                      },
                      validator: (String? value) {
                        if (!Validators.isValidPassword(value)) {
                          return invalidPasswordError;
                        }
                        return null;
                      },
                    ),
                    CustomTextForm(
                      hintText: 'Confirmer votre mot de passe...',
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (var t) {
                        password2 = t;
                      },
                      validator: (String? value) {
                        if (!Validators.isValidPassword(value)) {
                          return invalidPasswordError;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeVertical * 30,
                ),
                child: _buildSignInButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
