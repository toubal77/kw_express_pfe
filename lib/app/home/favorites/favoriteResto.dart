import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/feed/detail_resto/detail_resto_screen.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';

class FavoriteResto extends StatefulWidget {
  @override
  _FavoriteRestoState createState() => _FavoriteRestoState();
}

class _FavoriteRestoState extends State<FavoriteResto> {
  List<Restaurent?> _list = [];
  // Future getFavorite() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //get string favorites

  //   String? favorites = prefs.getString('favorite');
  //   List<Restaurant?>? favo = Restaurant.decode(favorites);
  //   favo!.forEach((element) {});
  //   _list = favo;
  // }

  @override
  void initState() {
    //  getFavorite();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Mes Restaurants Favoris',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return DetailRestoScreen(
            resto: _list[index]!,
            // isLoading: false,
          );
        },
      ),
    );
  }
}
