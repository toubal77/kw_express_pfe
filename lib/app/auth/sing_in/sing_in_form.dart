import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kw_express_pfe/app/auth/login_screen.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String phone,
    required bool loginPhone,
  }) onSaved;

  @override
  Widget build(BuildContext context) {
    late final _formKey = GlobalKey<FormState>();
    String phone = '';
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  whiteLogo,
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: SizedBox(
                  width: 222.w,
                  height: 63.h,
                  child: Text(
                    'Get your groceries with K&W Express',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff030303),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 25, right: 25, bottom: 10),
                child: CustomTextForm(
                  fillColor: Colors.white,
                  title: 'Numéro de téléphone:',
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  isPhoneNumber: true,
                  onChanged: (var value) {
                    phone = value;
                    phone = phone.replaceFirst(RegExp('0'), '');
                    phone = '+213$phone';
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
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: SignUpDivider(),
              ),
              GestureDetector(
                onTap: () {
                  onSaved(
                    phone: phone,
                    loginPhone: false,
                  );
                },
                child: Center(
                  child: Text(
                    'Or connect with mail',
                    style: TextStyle(
                      color: Color(0xff828282),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ButtomMedia(
                press: () {
                  // if (_formKey.currentState!.validate() && phone.length == 0) {
                  onSaved(
                    phone: phone,
                    loginPhone: true,
                  );
                  //  }
                },
                color: Color(0xff5383EC),
                text: 'Suivant',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
