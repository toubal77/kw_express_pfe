import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtomMedia extends StatelessWidget {
  final String iconName;
  final Color color;
  final String text;
  final Function()? press;
  const ButtomMedia({
    Key? key,
    required this.iconName,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 35.91),
          child: Row(
            children: [
              SizedBox(
                width: 22.95.w,
                child: SvgPicture.asset(
                  iconName,
                ),
              ),
              const SizedBox(
                width: 40.22,
              ),
              Text(
                'Continue with $text',
                style: TextStyle(
                  color: Color(0xffFCFCFC),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
