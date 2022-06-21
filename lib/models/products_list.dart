import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import '../utils/constantes.dart';

class ProductsList with ChangeNotifier {
  final String _token;
  final String uid;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get FavoriteItems =>
      items.where((prod) => prod.isFavorite).toList();

  ProductsList([
    this._token = '',
    this.uid = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse("${Constantes.BASE_URL}.json?auth=$_token"),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse("${Constantes.USER_FAVORITE}/$uid.json?auth=$_token"),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null'
        ? {} 
        : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final _isFavorite = favData['$productId'] ?? false;
      _items.add(
        Product(
          id: productId,
          title: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: _isFavorite,
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

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product item) async {
    final response = await http.post(
      Uri.parse("${Constantes.BASE_URL}.json?auth=$_token"),
      body: jsonEncode(
        {
          'name': item.title,
          'description': item.description,
          'price': item.price,
          'imageUrl': item.imageUrl,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        title: item.title,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
          Uri.parse("${Constantes.BASE_URL}/${product.id}.json?auth=$_token"));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possivel excluir produto',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
