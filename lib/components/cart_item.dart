import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text("${cartItem.price}"),
            ),
          ),
        ),
        title: Text(cartItem.title),
        subtitle: Text('Total: \$ ${cartItem.price * cartItem.quantity}'),
        trailing: Text('${cartItem.quantity}'),
      ),
    );
  }
}
