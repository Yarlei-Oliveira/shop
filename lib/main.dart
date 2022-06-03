import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/products_list.dart';
<<<<<<< HEAD
import 'package:shop/pages/cart_page.dart';
=======
>>>>>>> 42cd30f85b36ac4c764f69ead3c893f2d6b2d967
import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/provider/couter_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        home: ProductOverview(),
        routes: {
          AppRoutes.PRODUCTDETAIL: (context) => CounterPage(),
<<<<<<< HEAD
          AppRoutes.CARTPAGE: (context) => CartPage(),
=======
>>>>>>> 42cd30f85b36ac4c764f69ead3c893f2d6b2d967
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
