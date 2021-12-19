import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kw_express_pfe/constants/assets_constants.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.6.w,
      height: 233.1.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            splash_screen,
          ),
        ),
      ),
    );
  }
}
