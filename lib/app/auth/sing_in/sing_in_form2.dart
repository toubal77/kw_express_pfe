import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class SignInForm2 extends StatefulWidget {
  const SignInForm2({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String email,
    required String password,
  }) onSaved;

  @override
  State<SignInForm2> createState() => _SignInForm2State();
}

class _SignInForm2State extends State<SignInForm2> {
  late final _formKey = GlobalKey<FormState>();
  bool pswVisible = false;
  late String email = '';
  late String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(whiteLogo),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width.w,
              margin: const EdgeInsets.only(left: 24.95, right: 24.95),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 82.w,
                      height: 29.h,
                      child: Text(
                        'Loging',
                        style: TextStyle(
                          color: Color(0xff181725),
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 233.w,
                      height: 14.h,
                      child: Text(
                        'Enter your email and password',
                        style: TextStyle(
                          color: Color(0xff7C7C7C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: CustomTextForm(
                        fillColor: Colors.white,
                        textInputType: TextInputType.emailAddress,
                        title: 'Email:',
                        textInputAction: TextInputAction.done,
                        isPhoneNumber: false,
                        onChanged: (var value) {
                          email = value;
                        },
                        validator: (String? value) {
                          if (!Validators.isValidEmail(value)) {
                            return invalidEmailError;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: CustomTextForm(
                        fillColor: Colors.white,
                        textInputType: TextInputType.visiblePassword,
                        title: 'Password:',
                        textInputAction: TextInputAction.done,
                        isPhoneNumber: false,
                        isPassword: true,
                        onChanged: (var value) {
                          password = value;
                        },
                        validator: (String? value) {
                          if (!Validators.isValidPassword(value)) {
                            return invalidPasswordError;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      height: 14.h,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xff181725),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ButtomMedia(
                      press: () {
                        if (_formKey.currentState!.validate() &&
                            email != null &&
                            password != null) {
                          widget.onSaved(
                            email: email,
                            password: password,
                          );
                        }
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
          ],
        ),
      ),
    );
  }
}