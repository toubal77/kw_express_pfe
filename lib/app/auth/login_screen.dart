import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kw_express_pfe/app/auth/location.dart';
import 'package:kw_express_pfe/app/auth/signup_screen.dart';
import 'package:kw_express_pfe/app/auth/widgets/background_image.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pswVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Positioned(
          //   top: 0,
          //   child: BackgroundImage(),
          // ),
          Positioned(
            top: 100,
            child: Container(
              width: 47.82.w,
              height: 55.84.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(whiteLogo),
                ),
              ),
            ),
          ),
          Positioned(
            top: 235,
            left: 0,
            width: MediaQuery.of(context).size.width.w,
            child: Container(
              margin: const EdgeInsets.only(left: 24.95, right: 24.95),
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
                    height: 15.h,
                    child: Text(
                      'Enter your emails and password',
                      style: TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 233.w,
                    height: 15.h,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextFormField(
                      maxLines: 1,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Exemple@exemple.com',
                      ),
                      onChanged: (value) {
                        setState(() {
                          emailController.text = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 233.w,
                    height: 15.h,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xff7C7C7C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextFormField(
                      maxLines: 1,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: pswVisible ? true : false,
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: '°°°°',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              pswVisible = !pswVisible;
                            });
                          },
                          child: pswVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          passwordController.text = value;
                        });
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
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SelectLocation(arrow: false);
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: 364.w,
                      height: 67.h,
                      decoration: BoxDecoration(
                        color: Color(0xff53B175),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xffFFF9FF),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignupScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff181725),
                            letterSpacing: 0.05,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Singup',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff53B175),
                                letterSpacing: 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
