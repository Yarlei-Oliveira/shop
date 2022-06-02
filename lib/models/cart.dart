import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item => {..._items};

  int get itemCount {
    return _items.length;
    
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, CartItem) { 
      total += CartItem.price + CartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (itemExistenteCart) => CartItem(
          id: itemExistenteCart.id,
          productId: itemExistenteCart.productId,
          title: itemExistenteCart.title,
          quantity: itemExistenteCart.quantity + 1,
          price: itemExistenteCart.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }
}
