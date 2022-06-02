import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import '../data/dummy_data.dart';

class ProductsList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get FavoriteItems => items.where((prod) => prod.isFavorite).toList();


  void addItem(Product item) {
    _items.add;
    notifyListeners();
  }
}
