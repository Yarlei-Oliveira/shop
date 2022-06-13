import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/products_list.dart';
import 'package:shop/utils/routes.dart';

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({Key? key}) : super(key: key);

  Future<void> _refreshProduct(BuildContext context){
    return Provider.of<ProductsList>(context, listen:false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: product.itemsCount,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  ProductItem(product: product.items[i]),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
