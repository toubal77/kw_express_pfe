import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';

class BuildCouvResto extends StatelessWidget {
  const BuildCouvResto({
    Key? key,
    required this.resto,
  }) : super(key: key);

  final Restaurent resto;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            resto.couvPicture!,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
