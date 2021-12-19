import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_elevated_button.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';

class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({
    Key? key,
    required this.onNextPressed,
  }) : super(key: key);
  final ValueChanged<String> onNextPressed;

  @override
  _EnterPhoneNumberState createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
  String? phoneNumber;
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
          if (phoneNumber != null) {
            widget.onNextPressed(phoneNumber!);
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
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: CustomTextForm(
                    title: 'Votre numéro de téléphone:',
                    titleStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    maxLength: 10,
                    isPhoneNumber: true,
                    onChanged: (String value) {
                      phoneNumber = value;
                      phoneNumber = phoneNumber!.replaceFirst(RegExp('0'), '');
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
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 57,
                            child: VerticalDivider(
                              thickness: 1,
                              width: 20,
                              color: Colors.black,
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
