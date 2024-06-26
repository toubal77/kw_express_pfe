import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home/cart/buildItemCart.dart';
import 'package:kw_express_pfe/app/home/cart/cart_bloc.dart';
import 'package:kw_express_pfe/app/models/cart.dart';
import 'package:kw_express_pfe/app/models/order.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  final Restaurent resto;
  final User user;
  CartScreen(this.resto, this.user);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List commandes = [];
  late String codePromo;
  late CartBloc cartBloc;

  @override
  void initState() {
    final Database database = context.read<Database>();
    cartBloc = CartBloc(
      database: database,
      currentUser: widget.user,
    );

    super.initState();
  }

  late double total;
  late bool truck = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final cart = Provider.of<Cart>(context);
    total = cart.totalAmount;
    var tt = 0;
    if (widget.resto.remise != 0) {
      if (widget.resto.remise == -1)
        truck = true;
      else
        tt = (total * (widget.resto.remise / 100)).ceil();
      total = total - tt;
    }
    if (widget.resto.remise != -1) total = total + 250;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Panier',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            //  IconsApp.goBack,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  // commandes.add(
                  //   cart.items.values.toList()[index].quantity.toString() +
                  //       ' * ' +
                  //       cart.items.values.toList()[index].title.toString(),
                  // );
                  return BuildItemCart(
                    cart.items.values.toList()[index].price,
                    cart.items.values.toList()[index].quantity,
                    cart.items.values.toList()[index].title,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(
                  height: 3,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sous-Total:',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${cart.totalAmount} DA',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (widget.resto.remise > 0)
                  SizedBox(
                    height: 10,
                  ),
                if (widget.resto.remise > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Remise :',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '$tt DA',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Frais de livraison',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      truck ? '0 DA' : 'A partir de 250 DA',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total :',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$total  DA',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 3,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (!cart.itemEmpty) {
                        List<Map> orders = [];
                        final Uuid uuid = Uuid();

                        for (int i = 0; i < cart.items.length; i++) {
                          Map map = {
                            'name': cart.items.values.toList()[i].title,
                            'price': cart.items.values.toList()[i].price,
                            'quantity': cart.items.values.toList()[i].quantity,
                          };
                          orders.add(
                            map,
                          );
                        }

                        final order = Order(
                          id: uuid.v4(),
                          idResto: widget.resto.id,
                          price: total,
                          adress: 'address',
                          status: 'Attente de confirmation',
                          createdAt: Timestamp.now(),
                          createdBy: widget.user.id,
                          phone: widget.user.phoneNumber,
                          orderDetail: orders,
                        );
                        cartBloc.saveOrder(order);
                        cart.clear();
                        Fluttertoast.showToast(
                          msg: 'Votre commende esr passe avec succès',
                          toastLength: Toast.LENGTH_LONG,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        color: cart.itemEmpty ? Colors.grey : Colors.red,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          'COMMANDER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
