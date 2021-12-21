import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';

class BuildProfileBioResto extends StatelessWidget {
  const BuildProfileBioResto({
    Key? key,
    required this.resto,
  }) : super(key: key);

  final Restaurent resto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.white, width: 5.0),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              resto.profilePicture!,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
          child: Text(
            resto.bio!,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
