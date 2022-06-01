import 'package:flutter/material.dart';
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
    return CounterProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        home: ProductOverview(),
        routes: {
          AppRoutes.PRODUCTDETAIL:(context) => CounterPage(),
        },
        debugShowCheckedModeBanner: false,
    
        
      ),
    );
  }
}

