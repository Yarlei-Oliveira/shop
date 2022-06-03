import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, i){
          return OrderWidget(order: orders.items[i]);
        }
        ),

    );
  }
}