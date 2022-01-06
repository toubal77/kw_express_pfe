import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kw_express_pfe/app/models/Order_detail.dart';

class Order {
  final String id;
  final String phone;
  final String adress;
  final double price;
  final List orderDetail;
  final String createdBy;
  final Timestamp createdAt;
  Order({
    required this.id,
    required this.createdBy,
    required this.phone,
    required this.adress,
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
      'orderDetail': orderDetail.toList(),
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }

  factory Order.fromJson(Map<String, dynamic> data) {
    final String id = data['id'] as String;
    final String phone = data['phone'] as String;
    final double price = data['price'] as double;
    final String adress = data['adress'] as String;
    final List<OrderDetail> orderDetail =
        data['orderDetail'] as List<OrderDetail>;
    orderDetail.forEach((element) {
      OrderDetail.fromJson(element as Map<String, dynamic>);
    });

    final String createdBy = data['createdBy'] as String;
    final Timestamp createdAt =
        (data['createdAt'] as Timestamp?) ?? Timestamp.now();
    return Order(
      id: id,
      phone: phone,
      price: price,
      adress: adress,
      orderDetail: orderDetail,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}
