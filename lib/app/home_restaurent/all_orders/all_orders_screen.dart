import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kw_express_pfe/app/home_restaurent/all_orders/all_orders_bloc.dart';
import 'package:kw_express_pfe/app/models/order.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  late Stream<List<Order>> allOrder;
  late AllOrdersBloc bloc;
  @override
  void initState() {
    bloc = AllOrdersBloc(
      currentUser: context.read<User>(),
      database: context.read<Database>(),
    );
    allOrder = bloc.getMyOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Mes commandes',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 6.0,
      ),
      body: StreamBuilder<List<Order>>(
        stream: allOrder,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final List<Order> myOrders = snapshot.data!;
            return ListView.builder(
              itemCount: myOrders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Order myOrder = myOrders[index];
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Id: #${myOrders[index].id.substring(0, 8)}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                "Total: ${myOrders[index].price} DA",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          for (int i = 0; i < myOrder.orderDetail.length; i++)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Text(
                                        myOrder.orderDetail[i]['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${myOrder.orderDetail[i]['quantity']} x ${myOrder.orderDetail[i]['price']} DA',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, right: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Num Client: ${myOrder.phone}'),
                                TextButton(
                                  onPressed: () {
                                    launch('tel:${myOrder.phone}');
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
                            child: Text(
                                'status de la commande: ${myOrder.status}'),
                          ),
                          if (myOrder.status != "En route")
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (myOrder.status ==
                                      "Attente de confirmation") {
                                    //nrajaha En preparation
                                    bloc.changeStatus(
                                        myOrder, 'En preparation');
                                  }
                                  if (myOrder.status == "En preparation") {
                                    //nrajaha Attente de livreur
                                    bloc.changeStatus(
                                        myOrder, 'Attente de livreur');
                                  }
                                  if (myOrder.status == "Attente de livreur") {
                                    //nrajaha En route
                                    bloc.changeStatus(myOrder, 'En route');
                                  }
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
                                      'Next',
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
