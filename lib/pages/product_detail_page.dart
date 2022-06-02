import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text('titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(product.title),
      ),
    );
  }
}
