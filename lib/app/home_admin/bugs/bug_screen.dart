import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kw_express_pfe/app/home_admin/admin_logout.dart';
import 'package:kw_express_pfe/app/home_admin/bugs/bug_bloc.dart';
import 'package:kw_express_pfe/app/models/bug.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class BugScreen extends StatefulWidget {
  const BugScreen({Key? key}) : super(key: key);

  @override
  State<BugScreen> createState() => _BugScreenState();
}

class _BugScreenState extends State<BugScreen> {
  late Stream<List<Bug>> allBug;
  late BugBloc bloc;
  @override
  void initState() {
    bloc = BugBloc(
      currentUser: context.read<User>(),
      database: context.read<Database>(),
    );
    allBug = bloc.getAllRect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [AdminLogout()],
        iconTheme: IconThemeData(color: darkBlue),
        title: Text(
          'Réclamation / Bug',
          style: TextStyle(
            color: iconBackgroundColor,
          ),
        ),
      ),
      body: StreamBuilder<List<Bug>>(
        stream: allBug,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final List<Bug> myBugs = snapshot.data!;
            return ListView.builder(
              itemCount: myBugs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Bug myOrder = myBugs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: SizeConfig.screenWidth,
                      // height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bug Id: #${myBugs[index].id.substring(0, 8)}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, right: 5, bottom: 5),
                            child: "recla" == myOrder.type
                                ? Text('Type: réclamation')
                                : Text('Type: ${myOrder.type}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, right: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name Client: ${myOrder.name}'),
                                TextButton(
                                  onPressed: () {
                                    launch('tel:${myOrder.phoneNumber}');
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: SvgPicture.asset(
                                        'assets/drawable/phone.svg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, right: 5, bottom: 5),
                            child: Text('Description: ${myOrder.description}'),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                bloc.removeBug(myOrder.id);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Traiter',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (!(snapshot.hasData && snapshot.data != null)) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmptyContent(
                title: 'Aucune Données',
                message: '',
              ),
            );
          } else if (snapshot.hasError) {
            return EmptyContent(
              title: "Quelque chose s'est mal passé",
              message: "Impossible de charger les éléments pour le moment",
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
