import 'package:flutter/material.dart';

class BuildEspaceResto extends StatelessWidget {
  const BuildEspaceResto({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 25,
        ),
        Text(title),
      ],
    );
  }
}
