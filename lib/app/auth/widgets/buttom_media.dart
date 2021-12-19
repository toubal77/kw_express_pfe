import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtomMedia extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? press;
  const ButtomMedia({
    Key? key,
    required this.color,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 23),
        width: 364.w,
        height: 67.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xffFCFCFC),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
