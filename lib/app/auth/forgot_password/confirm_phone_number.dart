import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  const ConfirmPhoneNumber({
    Key? key,
    required this.onNextPressed,
  }) : super(key: key);

  final ValueChanged<String> onNextPressed;

  @override
  _ConfirmPhoneNumberState createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {
  late String? code;
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
          if (code != null) {
            widget.onNextPressed(code!);
          }
        }
      },
      color: Color(0xff5383EC),
      text: 'Suivant',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SizedBox(
          height: SizeConfig.screenHeight,
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
                "pour confirmer votre numéro de téléphone, entrez le code SMS ici:",
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextForm(
                      title: '',
                      hintText: 'CODE',
                      maxLength: 6,
                      isPhoneNumber: true,
                      textInputAction: TextInputAction.done,
                      onChanged: (var value) {
                        code = value;
                      },
                      validator: (String? value) {
                        if (!Validators.isValidVerificationCode(value)) {
                          return invalidVerificationCodeError;
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
