import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/pages/orders_pages.dart';
import 'package:shop/utils/custom_route.dart';
import 'package:shop/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo usuario'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.AUTHORHOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout_outlined),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              /* Navigator.of(context).pushReplacement(
                CustomRoute(builder: (context) => OrderPage())
              ); */
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.MANAGEMENT);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              auth.Logout();
              Navigator.of(context).pushNamed(AppRoutes.AUTHORHOME);
            },
          ),
        ],
      ),
    );
  }
}
