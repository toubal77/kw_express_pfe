import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/admin_logout.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/data_search.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/moderators_bloc.dart';
import 'package:kw_express_pfe/app/home_admin/moderators/user_tile.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/loading_screen.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class ModeratorsScreen extends StatefulWidget {
  const ModeratorsScreen({Key? key}) : super(key: key);

  @override
  _ModeratorsScreenState createState() => _ModeratorsScreenState();
}

class _ModeratorsScreenState extends State<ModeratorsScreen> {
  late final ModeratorsBloc bloc;
  late final Stream<List<User>> modList;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ValueNotifier<List<String>> modsIdsList = ValueNotifier([]);

  @override
  void initState() {
    bloc = ModeratorsBloc(database: context.read<Database>());
    modList = bloc.getModeratorsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: modsIdsList,
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              return Provider.value(
                value: bloc,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    actions: [AdminLogout()],
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: iconBackgroundColor,
                        ),
                        color: darkBlue,
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: DataSearch(modList, bloc),
                          );
                        },
                      ),
                    ),
                  ),
                  body: StreamBuilder<List<User>>(
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
                            modsIdsList.value = mods.map((e) => e.id).toList();

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
                      }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
