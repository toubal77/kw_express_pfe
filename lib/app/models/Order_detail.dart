class OrderDetail {
  String name;
  double price;
  int quantity;

  OrderDetail({
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderDetail.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final double price = data['price'] as double;
    final int quantity = data['quantity'] as int;
    return OrderDetail(
      name: name,
      price: price,
      quantity: quantity,
    );
  }
}
