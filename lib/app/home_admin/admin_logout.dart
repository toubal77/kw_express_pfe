import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/firebase_messaging_service.dart';
import 'package:provider/provider.dart';

class AdminLogout extends StatelessWidget {
  const AdminLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final Auth auth = context.read<Auth>();
        auth.signOut();

        final User user = context.read<User>();
        context.read<FirebaseMessagingService>().removeToken(user.id);
      },
      icon: Icon(
        Icons.logout,
        color: iconBackgroundColor,
      ),
    );
  }
}
