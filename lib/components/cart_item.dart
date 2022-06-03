import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 30),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
      },
      child: Card(
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
      ),
    );
  }
}
