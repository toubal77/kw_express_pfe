import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:kw_express_pfe/app/home/espace_client/my_order/my_order_bloc.dart';
import 'package:kw_express_pfe/app/models/order.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  late Stream<List<Order>> allOrder;
  late MyOrderBloc bloc;
  var _expanded = false;
  @override
  void initState() {
    bloc = MyOrderBloc(
      currentUser: context.read<User>(),
      database: context.read<Database>(),
    );
    allOrder = bloc.getMyOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.red,
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
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _expanded
                      ? myOrders[index].orderDetail.length != 1
                          ? min(myOrders[index].orderDetail.length * 40.0 + 130,
                              250)
                          : min(myOrders[index].orderDetail.length * 40.0 + 140,
                              270)
                      : 95,
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            title: Text('${myOrders[index].price} DA'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  GetTimeAgo.parse(
                                      myOrders[index].createdAt.toDate()),
                                ),
                                Text(
                                  myOrders[index].status,
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.verified,
                                    color: myOrders[index].status ==
                                            'Attente de confirmation'
                                        ? Colors.red
                                        : myOrders[index].status ==
                                                    'Attente de livreur' ||
                                                myOrders[index].status ==
                                                    'en preparation'
                                            ? Colors.orange
                                            : Colors.green,
                                  ),
                                  IconButton(
                                    icon: Icon(_expanded
                                        ? Icons.expand_less
                                        : Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded = !_expanded;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          height: _expanded
                              ? myOrders[index].orderDetail.length != 1
                                  ? min(
                                      myOrders[index].orderDetail.length *
                                              70.0 +
                                          180,
                                      118)
                                  : min(
                                      myOrders[index].orderDetail.length *
                                              20.0 +
                                          120,
                                      85)
                              : 0,
                          child: ListView.builder(
                            itemCount: myOrder.orderDetail.length,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        child: Text(
                                          myOrder.orderDetail[index]['name'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${myOrder.orderDetail[index]['quantity']} x ${myOrder.orderDetail[index]['price']} DA',
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
                              );
                            },
                          ),
                        ),
                      ],
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
