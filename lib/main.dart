import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/products_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_pages.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/product_management_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.purple,
          backgroundColor: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange),
          fontFamily: GoogleFonts.lato().fontFamily, 
        ),
        home: ProductOverview(),
        routes: {
          AppRoutes.HOME:(context) => ProductOverview(),
          AppRoutes.CARTPAGE: (context) => CartPage(),
          AppRoutes.ORDERS:(context) => OrderPage(),
          AppRoutes.PRODUCTDETAIL: (context) => ProductDetail(),
          AppRoutes.MANAGEMENT:(context) => ProductManagementPage(),
          AppRoutes.PRODUCT_FORM:(context) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
