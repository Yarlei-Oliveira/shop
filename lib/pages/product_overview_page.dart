import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/routes.dart';

import '../components/product_grid.dart';

enum Options { favorite, all }

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Só favoritos'),
                value: Options.favorite,
              ),
              PopupMenuItem(
                child: Text('Exibir todos'),
                value: Options.all,
              ),
            ],
            onSelected: (Options option) {
              setState(() {
                if (option == Options.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.CARTPAGE);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            builder: (context, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: ProductWidget(_showFavoriteOnly),
    );
  }
}
