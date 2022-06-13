import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import '../data/dummy_data.dart';

class ProductsList with ChangeNotifier {
  final _url = 'https://shop-19b98-default-rtdb.firebaseio.com/product.json';

  List<Product> _items = [];

  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get FavoriteItems =>
      items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse(_url));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          title: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        title: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String);

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product item) async {
    final response = await http.post(Uri.parse(_url),
        body: jsonEncode({
          'name': item.title,
          'description': item.description,
          'price': item.price,
          'imageUrl': item.imageUrl,
          'isFavorite': item.isFavorite,
        }));

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        title: item.title,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        isFavorite: item.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
    return Future.value();
  }
}
