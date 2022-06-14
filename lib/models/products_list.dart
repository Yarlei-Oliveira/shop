import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import '../utils/constantes.dart';

class ProductsList with ChangeNotifier {


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
    final response = await http.get(
      Uri.parse("${Constantes.BASE_URL}.json"),
    );
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

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final response = await http.patch(
        Uri.parse("${Constantes.BASE_URL}/${product.id}.json"),
        body: jsonEncode(
          {
            'name': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product item) async {
    final response = await http.post(
      Uri.parse("${Constantes.BASE_URL}.json"),
      body: jsonEncode(
        {
          'name': item.title,
          'description': item.description,
          'price': item.price,
          'imageUrl': item.imageUrl,
          'isFavorite': item.isFavorite,
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
        isFavorite: item.isFavorite,
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

      final response =
          await http.delete(Uri.parse("${Constantes.BASE_URL}/${product.id}.json"));

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
