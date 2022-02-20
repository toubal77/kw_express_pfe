import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyOffreResto extends StatelessWidget {
  const EmptyOffreResto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 3,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 3,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 3,
                offset: Offset(8, 8),
              ),
            ],
          ),
          child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
        ),
      ],
    );
  }
}
