import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import './product_grid_item_.dart';
import '../models/products_list.dart';

class ProductWidget extends StatelessWidget {
  final bool _showFavoriteItems;
  ProductWidget(this._showFavoriteItems);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsList>(context);
    final List<Product> LoadedProduct = _showFavoriteItems
    ? provider.FavoriteItems
    : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: LoadedProduct.length,
      itemBuilder: (context, i) {
        return ChangeNotifierProvider.value(
          child: ProductGridItem(),
          value: LoadedProduct[i],
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
