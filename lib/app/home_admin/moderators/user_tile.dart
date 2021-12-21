import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/moderators_bloc.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/platform_alert_dialog.dart';

class UserTile extends StatefulWidget {
  const UserTile({
    Key? key,
    required this.user,
    required this.initialValue,
    required this.moderatorsBloc,
    required this.onCheckBoxClicked,
  }) : super(key: key);
  final User user;
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
    isMod = widget.user.isModerator;
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
          imageUrl: widget.user.profilePicture!,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(widget.user.name),
      trailing: Checkbox(
        value: isMod,
        onChanged: (t) async {
          if (t != null) {
            final bool? didRequestSignOut = await PlatformAlertDialog(
              title: 'Confirmer',
              content: t
                  ? 'êtes-vous sûr de vouloir faire de cet utilisateur un moderateur'
                  : 'êtes-vous sûr de vouloir supprime cet utilisateur de moderateur',
              cancelActionText: 'annuler',
              defaultActionText: 'oui',
            ).show(context);
            if (didRequestSignOut == true) {
              widget.moderatorsBloc.makeUserMod(
                widget.user,
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
