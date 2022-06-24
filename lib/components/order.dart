import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  OrderWidget({required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final orderHeight = (widget.order.products.length * 25.0) + 10;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? orderHeight + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Total: \$${widget.order.total.toStringAsFixed(2)}'),
              subtitle: Text(
                  DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(Icons.expand_more),
              ),
            ),
            //if (_expanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded ? orderHeight : 0,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${product.quantity}x R\$ ${product.price}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          )),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
