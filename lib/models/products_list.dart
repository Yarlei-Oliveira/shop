import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import '../data/dummy_data.dart';

class ProductsList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get FavoriteItems =>
      items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
        id: hasId 
        ? data['id'] as String
        :Random().nextDouble().toString(),
        title: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String
        );

    if(hasId){
      updateProduct(newProduct);
    }else{
      addItem(newProduct);
    }
  }

  void updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if( index >= 0){
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if( index >= 0){
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void addItem(Product item) {
    _items.add(item);
    notifyListeners();
  }


}
