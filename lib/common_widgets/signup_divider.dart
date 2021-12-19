import 'package:flutter/material.dart';

class SignUpDivider extends StatelessWidget {
  SignUpDivider({Key? key}) : super(key: key);

  final double thickness = 4;
  final Color color = Color.fromRGBO(255, 255, 255, 0.5);
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color,
    );
  }
}
