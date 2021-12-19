import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kw_express_pfe/app/auth/verification_screen.dart';
import 'package:kw_express_pfe/app/auth/widgets/background_image.dart';
import 'package:kw_express_pfe/app/auth/widgets/text_contains_enter.dart';
import 'package:kw_express_pfe/app/auth/widgets/text_enter.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  String dropdownValue = '+213';
  TextEditingController phoneNumber = TextEditingController();
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
          BackgroundImage(),
          TextEnter(text: 'Enter your mobile number'),
          TextContainsEnter(text: 'Mobile Number'),
          Positioned(
            top: 235,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.95, right: 24.95),
              child: SizedBox(
                height: 30.h,
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        width: MediaQuery.of(context).size.width.w,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        '+1',
                        '+33',
                        '+34',
                        '+36',
                        '+212',
                        '+213',
                        '+214'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: 17,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width.w * 0.6,
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                        ),
                        onChanged: (value) {
                          setState(() {
                            phoneNumber.text = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (phoneNumber.text.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const VerificationScreen();
                },
              ),
            );
          }
        },
        child: Container(
          width: 67.w,
          height: 67.h,
          decoration: BoxDecoration(
            color: phoneNumber.text.isNotEmpty
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
