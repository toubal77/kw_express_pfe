import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/moderators_bloc.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/miniuser_to_profile.dart';
import 'package:kw_express_pfe/common_widgets/platform_alert_dialog.dart';

class UserTile extends StatefulWidget {
  const UserTile({
    Key? key,
    required this.miniUser,
    required this.initialValue,
    required this.moderatorsBloc,
    required this.onCheckBoxClicked,
  }) : super(key: key);
  final User miniUser;
  final bool initialValue;
  final ModeratorsBloc moderatorsBloc;
  final VoidCallback onCheckBoxClicked;

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  late bool isMod;
  @override
  void initState() {
    isMod = widget.miniUser.isModerator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(47),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.miniUser.profilePicture!,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(widget.miniUser.name),
      trailing: Checkbox(
        value: isMod,
        onChanged: (t) async {
          if (t != null) {
            final bool? didRequestSignOut = await PlatformAlertDialog(
              title: 'Confirmer',
              content:
                  'êtes-vous sûr de vouloir faire de cet utilisateur un moderateur',
              cancelActionText: 'annuler',
              defaultActionText: 'oui',
            ).show(context);
            if (didRequestSignOut == true) {
              widget.moderatorsBloc.makeUserMod(
                widget.miniUser,
                isMod: t,
              );
              setState(() {
                isMod = t;
              });
              widget.onCheckBoxClicked();
            }
          }
        },
      ),
      onTap: () {},
    );
  }
}
