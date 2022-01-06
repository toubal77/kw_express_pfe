import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:kw_express_pfe/app/home/cart/buildItemCart.dart';
import 'package:kw_express_pfe/app/models/cart.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  final nomRsto;
  CartScreen(this.nomRsto);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List commandes = [];
  late String codePromo;

  late double total;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final cart = Provider.of<Cart>(context);
    total = cart.totalAmount;
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
                      'A partir de 400 DA',
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
                      '${cart.totalAmount + 400} DA',
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
                      if (cart.itemEmpty) {
                        var message = StringBuffer();
                        commandes.add('Restaurant: ' + widget.nomRsto + '\n\n');

                        double commandePrice = cart.totalAmount + 400;
                        commandes.add('Somme: ' +
                            commandePrice.toString() +
                            'DA' +
                            '\n\n');
                        for (int i = 0; i < cart.items.length; i++) {
                          commandes.add(
                            cart.items.values.toList()[i].quantity.toString() +
                                ' * ' +
                                cart.items.values.toList()[i].title.toString(),
                          );
                        }

                        List<String> recipents = ["0659185831"];
                        commandes.forEach((item) {
                          message.write(item + "\n\n");
                        });
                        print(commandes);
                        String _result = await sendSMS(
                                message: message.toString(),
                                recipients: recipents)
                            .catchError((onError) {
                          print(onError);
                        });
                        print(_result);
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
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



// Container(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Divider(
//               height: 3,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Sous-Total:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   '400 DA',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Frais de livraison',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Text(
//                   'A partir de 400 DA',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total :',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   '800 DA',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Divider(
//               height: 3,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: Container(
//                 width: 130,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'COMMANDER',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),



      //  Container(
      //             padding: const EdgeInsets.all(10),
      //             margin: const EdgeInsets.all(8),
      //             width: MediaQuery.of(context).size.width,
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey,
      //                   blurRadius: 1,
      //                   offset: Offset(0, 1),
      //                 ),
      //               ],
      //               borderRadius: BorderRadius.circular(5),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       '1 x Pizzas - Marqherita',
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w900,
      //                         fontSize: 15,
      //                       ),
      //                     ),
      //                     Text(
      //                       '400 DA',
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w900,
      //                         fontSize: 15,
      //                         color: Colors.red,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Container(
      //                   width: 100,
      //                   height: 50,
      //                   decoration: BoxDecoration(
      //                     color: Colors.red,
      //                     borderRadius: BorderRadius.circular(40),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       'SUPPRIMER',
      //                       style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 13,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),