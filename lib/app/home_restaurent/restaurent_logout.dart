import 'package:flutter/material.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:provider/provider.dart';

class RestaurentLogout extends StatelessWidget {
  const RestaurentLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<Auth>().signOut();
      },
      icon: Icon(Icons.logout, color: Colors.black),
    );
  }
}
