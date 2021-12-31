import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';

class OffreResto extends StatefulWidget {
  @override
  _OffreRestoState createState() => _OffreRestoState();
}

class _OffreRestoState extends State<OffreResto> {
  List<Restaurent?> _list = [];
  // Future<List<OffresResto?>?> getOffreResto() async {
  //   try {
  //     var url = Uri.parse(ApiApp.restaurant);
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       print('seccus get offre Resto');
  //       final data = json.decode(response.body)["offre"];
  //       setState(() {
  //         for (Map<String, dynamic> i in data) {
  //           _list.add(OffresResto.fromJson(i));
  //         }
  //       });
  //     } else {
  //       print('field get offre Resto');
  //       print('Response status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('field to try get offre Resto');
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    // getOffreResto().then((value) {
    for (int i = 0; i < _list.length; i++) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    child: Image.network(
                      _list[i]!.profilePicture!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: DecoratedBox(
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        // borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 3,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            //   child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 3,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            //  child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 3,
                  offset: Offset(8, 8),
                ),
              ],
            ),
            //       child: SvgPicture.asset('assets/drawable/resto_offre.svg'),
          ),
        ],
      ),
    );
  }
}
