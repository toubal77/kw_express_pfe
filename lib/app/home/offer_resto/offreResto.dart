import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/feed/feed_bloc.dart';
import 'package:kw_express_pfe/app/home/feed/widget/build_resto.dart';
import 'package:kw_express_pfe/app/home/offer_resto/widgets/empty_offre_resto.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class OffreResto extends StatefulWidget {
  @override
  _OffreRestoState createState() => _OffreRestoState();
}

class _OffreRestoState extends State<OffreResto> {
  late FeedBloc bloc;
  late Stream<List<Restaurent>> allRestaurent;
  @override
  void initState() {
    bloc = FeedBloc(
      currentUser: context.read<User>(),
      database: context.read<Database>(),
    );
    allRestaurent = bloc.getAllResto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Offres Restaurants',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: StreamBuilder<List<Restaurent?>>(
        stream: allRestaurent,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Restaurent?> typeMenu = snapshot.data!;
            List<Restaurent?> restoo = [];
            for (Restaurent? res in restoo) {
              if (res!.remise == 0) {
                restoo.add(res);
              }
            }
            print('dpsqg gpzdh  pzer ${typeMenu.length}');
            print('dpsqg iugiudh  pzer ${restoo.length}');
            typeMenu = restoo;
            if (typeMenu.length != 0)
              return ListView.builder(
                itemCount: typeMenu.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CardBuildRestaurent(
                    res: typeMenu[index],
                    isLoading: false,
                  );
                },
              );
            else
              return EmptyOffreResto();
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
