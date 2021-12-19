import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/location.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController codeVerification = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44FFFEFE),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
          color: Color(0xff181725),
        ),
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: 414.6.w,
            height: 233.1.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  whiteLogo,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 308.w,
              height: 29.h,
              margin: const EdgeInsets.only(left: 25.07, top: 65.19),
              child: Text(
                'Enter your 4-digit code',
                style: TextStyle(
                  color: Color(0xff181725),
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Positioned(
            top: 205,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.95),
              child: Text(
                'Code',
                style: TextStyle(
                  color: Color(0xff7C7C7C),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 235,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.95, right: 24.95),
              child: SizedBox(
                height: 30.h,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width.w * 0.6,
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff181725),
                    ),
                    decoration: InputDecoration(
                      hintText: '- - - -',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xff181725),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        codeVerification.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (codeVerification.text.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const SelectLocation(arrow: true);
                },
              ),
            );
          }
        },
        child: Container(
          width: 67.w,
          height: 67.h,
          decoration: BoxDecoration(
            color: codeVerification.text.isNotEmpty
                ? Color(0xff53B175)
                : Color(0xFF7A7A7A),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Platform.isIOS
                ? Icon(Icons.arrow_forward_ios)
                : Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
