import 'package:flutter/material.dart';

class BuildEspaceClient extends StatelessWidget {
  const BuildEspaceClient({
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
