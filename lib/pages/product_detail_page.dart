import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                product.price.toString(),
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.description.toString(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
