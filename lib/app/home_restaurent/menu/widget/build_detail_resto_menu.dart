import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';

class BuildDetailRestoMenu extends StatefulWidget {
  final MenuRestaurent? res;
  BuildDetailRestoMenu({
    Key? key,
    required this.res,
  }) : super(key: key);

  @override
  _BuildDetailRestoMenuState createState() => _BuildDetailRestoMenuState();
}

class _BuildDetailRestoMenuState extends State<BuildDetailRestoMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.res!.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.res!.description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.res!.prix} DA',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
