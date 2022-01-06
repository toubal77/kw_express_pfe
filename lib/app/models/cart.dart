import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  bool get itemEmpty {
    if (_items.length == 0)
      return true;
    else
      return false;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String title,
    int quantity,
    double price,
  ) {
    if (_items.containsKey(title)) {
      _items.update(
        title,
        (existingCartItem) => CartItem(
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + quantity,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        title,
        () => CartItem(
          title: title,
          quantity: quantity,
          price: price,
        ),
      );
    }
    print('item added to cart');
    print(_items);
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();

    print('item removeItem to cart');
  }

  void removeSingleItem(String title) {
    if (!_items.containsKey(title)) {
      return;
    }
    if (_items[title]!.quantity > 1) {
      _items.update(
          title,
          (existingCartItem) => CartItem(
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(title);
    }
    notifyListeners();
    print('item remove Single Item to cart');
  }

  void clear() {
    _items = {};
    notifyListeners();
    print('clear to cart');
  }
}
