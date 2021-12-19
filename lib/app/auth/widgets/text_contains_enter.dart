import 'package:flutter/material.dart';

class TextContainsEnter extends StatelessWidget {
  final String text;
  const TextContainsEnter({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 205,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.95),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff7C7C7C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
