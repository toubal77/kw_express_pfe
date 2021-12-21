import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/mini_user.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/loading_screen.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class MiniuserToProfile extends StatelessWidget {
  const MiniuserToProfile({
    Key? key,
    required this.miniUser,
  }) : super(key: key);
  final MiniUser miniUser;

  @override
  Widget build(BuildContext context) {
    final Database database = context.read<Database>();

    return FutureBuilder<User?>(
      future: database.fetchDocument(
        path: APIPath.userDocument(miniUser.id),
        builder: (data, documentId) {
          final data2 = User.fromMap2(data, documentId);
          return data2;
        },
      ),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData && (snapshot.data != null)) {
          //   final User user = snapshot.data!;
          // return ProfileScreen(user: user);
        } else if (snapshot.hasError) {
          EmptyContent(
            title: '',
            message: snapshot.error.toString(),
          );
        }
        return LoadingScreen(showAppBar: false);
      },
    );
  }
}
