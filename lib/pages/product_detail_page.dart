import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(product.title),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: product.id,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, 0.8),
                          end: Alignment(0, 0),
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0.6),
                            Color.fromRGBO(0, 0, 0, 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  " R\$ ${product.price.toString()}",
                  textAlign: TextAlign.center,
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
          )
        ],
      ),
    );
  }
}
