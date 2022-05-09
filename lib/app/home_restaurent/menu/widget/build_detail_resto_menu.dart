import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home_restaurent/new_menu/new_menu_screen.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';

class BuildDetailRestoMenu extends StatefulWidget {
  final MenuRestaurent? res;
  final RestaurentBloc bloc;
  BuildDetailRestoMenu({
    Key? key,
    required this.res,
    required this.bloc,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.res!.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    widget.res!.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
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
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.bloc.deleteProduct(widget.res!);
                    Fluttertoast.showToast(
                      msg: 'Les informations sont supprime avec succès',
                      toastLength: Toast.LENGTH_LONG,
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return NewMenuScreen(menuResto: widget.res);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.mode_edit,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
