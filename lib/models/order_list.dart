import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constantes.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _uid;
  List<Order> _items = [];

  OrderList([
    this._token = '',
    this._uid = '',
    this._items = const [],
  ]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http.get(
      Uri.parse('${Constantes.ORDER_URL}/$_uid.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    final data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              title: item['title'].toString(),
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });

    _items = items.reversed.toList();

    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("${Constantes.ORDER_URL}/$_uid.json?auth=$_token"),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.item.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'title': cartItem.title,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.item.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
