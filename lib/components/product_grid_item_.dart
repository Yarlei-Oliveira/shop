// ignore_for_file: use_key_in_widget_constructors

import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';

import '../utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.PRODUCTDETAIL, arguments: product);
        },
        child: GridTile(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
                placeholder: AssetImage(
                    'lib/assets/imagespngtree-web-ui-design-2-5d-icon-loading-ai-vector-png-free-image_1332562.jpg'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover),
          ),
          /* child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ), */
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavorite(
                  auth.token ?? '',
                  auth.uid ?? '',
                );
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              style: GoogleFonts.lato(),
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Produto adicionado com Sucesso!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
