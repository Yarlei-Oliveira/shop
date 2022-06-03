import 'package:flutter/material.dart';
import 'package:shop/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_checkout_outlined),
            title: Text('Pedidos'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          )
        ],
      ),
    );
  }
}