import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/moderators_bloc.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/user_tile.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/loading_screen.dart';

class DataSearch extends SearchDelegate<String> {
  final modList;
  final ModeratorsBloc bloc;
  DataSearch(this.modList, this.bloc);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, 'value');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildResult(context);
  @override
  Widget buildSuggestions(BuildContext context) => buildResult(context);

  Widget buildResult(BuildContext context) {
    return StreamBuilder<List<User>>(
        stream: modList,
        builder: (_, snapshot) {
          if (snapshot.hasData && (snapshot.data != null)) {
            final List<User> mods = snapshot.data!;
            if (mods.isEmpty) {
              return EmptyContent(
                title: 'there are no moderator',
                message: '',
              );
            } else {
              return ListView.builder(
                key: UniqueKey(),
                itemCount: mods.length,
                itemBuilder: (_, index) {
                  return UserTile(
                    user: mods[index],
                    moderatorsBloc: bloc,
                    onCheckBoxClicked: () {
                      //setState(() {});
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContent(
              title: '',
              message: snapshot.error.toString(),
            );
          }
          return LoadingScreen(showAppBar: false);
        });
  }
}
