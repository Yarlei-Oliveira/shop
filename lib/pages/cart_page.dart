import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.item.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(cart.totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color,
                        )),
                  ),
                  Spacer(),
                  _CartButtom(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              return CartItemWidget(cartItem: items[i]);
            },
          )),
        ],
      ),
    );
  }
}

class _CartButtom extends StatefulWidget {
  const _CartButtom({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<_CartButtom> createState() => _CartButtomState();
}

class _CartButtomState extends State<_CartButtom> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? CircularProgressIndicator()
    :TextButton(
      onPressed: widget.cart.itemCount == 0
          ? null
          : () async {
              setState(() => _isLoading = true);

              await Provider.of<OrderList>(context, listen: false)
                  .addOrder(widget.cart);

              widget.cart.clear();
              setState(() => _isLoading = false);
            },
      child: Text(
        'COMPRAR',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
