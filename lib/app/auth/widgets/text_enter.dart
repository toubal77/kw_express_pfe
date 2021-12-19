import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextEnter extends StatelessWidget {
  final String text;
  const TextEnter({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: 308.w,
        height: 29.h,
        margin: const EdgeInsets.only(left: 25.07, top: 65.19),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff181725),
            fontWeight: FontWeight.w600,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
