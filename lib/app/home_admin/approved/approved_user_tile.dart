import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/approved/approved_bloc.dart';
import 'package:kw_express_pfe/app/models/user.dart';

import 'nested_screens/restaurent_detail_screen.dart';

class ApprovedUserTile extends StatelessWidget {
  const ApprovedUserTile({
    Key? key,
    required this.user,
    required this.bloc,
  }) : super(key: key);

  final User user;
  final ApprovedBloc bloc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Container(
      //   width: 50,
      //   height: 50,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(47),
      //     border: Border.all(
      //       width: 2,
      //       color: Colors.white,
      //     ),
      //   ),
      //   child: CachedNetworkImage(
      //     imageUrl: user.profilePicture,
      //     imageBuilder: (context, imageProvider) => CircleAvatar(
      //       backgroundImage: imageProvider,
      //     ),
      //     errorWidget: (context, url, error) => Icon(Icons.error),
      //   ),
      // ),
      title: Text(user.name),

      onTap: () {
        print(user.id);
        print(user.toMap());

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RestaurentDetailScreen(restaurent: user, bloc: bloc),
          ),
        );
      },
    );
  }
}
