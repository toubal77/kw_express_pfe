import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kw_express_pfe/app/models/Order_detail.dart';

class Order {
  final String id;
  final String phone;
  final String adress;
  final double price;
  final List<Map> orderDetail;
  final String status;
  final String createdBy;
  final Timestamp createdAt;
  Order({
    required this.id,
    required this.createdBy,
    required this.phone,
    required this.adress,
    required this.status,
    required this.createdAt,
    required this.orderDetail,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'price': price,
      'adress': adress,
      'status': status,
      'orderDetail': orderDetail.toList(),
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = data['id'] as String;
    final String phone = data['phone'] as String;
    final double price = data['price'] as double;
    final String adress = data['adress'] as String;
    final String status = data['status'] as String;

    final List<Map> orderDetail = [];
    // = data['orderDetail'].map((item) {
    //   return item.forEach((element) {
    //     return OrderDetail(
    //       name: item["name"],
    //       price: item["price"],
    //       quantity: item["quantity"],
    //     );
    //   });
    // });

    for (var item in data['orderDetail']) {
      print('The list $orderDetail');
      print('The item $item');
      orderDetail.add(item);
      print('The list $orderDetail');
    }
    final String createdBy = data['createdBy'] as String;
    final Timestamp createdAt =
        (data['createdAt'] as Timestamp?) ?? Timestamp.now();
    return Order(
      id: id,
      phone: phone,
      price: price,
      adress: adress,
      status: status,
      orderDetail: orderDetail,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}
