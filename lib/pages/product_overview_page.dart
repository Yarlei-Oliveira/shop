import 'package:flutter/material.dart';
import 'package:shop/components/productItems.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

// ignore: use_key_in_widget_constructors
class ProductOverview extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final List<Product> LoadedProduct = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: LoadedProduct.length,
          itemBuilder: (context, i) {
            return ProductItem(product: LoadedProduct[i]);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
