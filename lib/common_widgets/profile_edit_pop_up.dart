import 'package:flutter/material.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:provider/provider.dart';

enum Options {
  editprofile,
  singout,
}

class ProfileEditPopUp extends StatefulWidget {
  const ProfileEditPopUp({
    Key? key,
    required this.onEditPressed,
  }) : super(key: key);
  final VoidCallback onEditPressed;
  @override
  _ProfileEditPopUpState createState() => _ProfileEditPopUpState();
}

class _ProfileEditPopUpState extends State<ProfileEditPopUp> {
  late bool showPopMenu;

  @override
  Widget build(BuildContext context) {
    final Auth auth = context.read<Auth>();

    return PopupMenuButton(
      onSelected: (Options selectedValue) {
        setState(() {
          if (selectedValue == Options.editprofile) {
            widget.onEditPressed();
          } else if (selectedValue == Options.singout) {
            auth.signOut();
          }
        });
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: Options.editprofile,
          child: Text(
            'Edit profil',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        PopupMenuItem(
          height: 5,
          value: Options.editprofile,
          child: Divider(
            height: 3,
            color: Colors.black,
          ),
        ),
        PopupMenuItem(
          value: Options.singout,
          child: Text(
            'Sign out',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
      ],
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 25,
      ),
    );
  }
}
