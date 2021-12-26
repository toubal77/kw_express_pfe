import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/models/cart.dart';
import 'package:provider/provider.dart';

class BuildItemCart extends StatelessWidget {
  final int price;
  final int quantity;
  final String title;

  BuildItemCart(
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$quantity x $title',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              Text(
                '$price DA',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              cart.removeSingleItem(title);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  'SUPPRIMER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
