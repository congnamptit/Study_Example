import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:udemy_example/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_example/widgets/exception_handle.dart';

class ProductProvider with ChangeNotifier {
  late Dio _dio;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference reference = FirebaseDatabase.instance.ref('products');

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((e) => e.id.toString() == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse('https://shopping-ae75d-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) ?? <String, dynamic>{};
      List<Product> loadedProducts = [];
      print(extractedData);
      extractedData.forEach((prodId, productData) {
        loadedProducts.add(
          Product(
            id: productData,
            title: productData['title'].toString(),
            description: productData['description'].toString(),
            price: double.tryParse(productData['price']),
            isFavorite: productData['isFavorite'],
            imageUrl: productData['imageUrl'].toString(),
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://shopping-ae75d-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id.toString() == id);
    if (productIndex >= 0) {
      var url = Uri.parse(
          'https://shopping-ae75d-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }),
      );
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.parse(
        'https://shopping-ae75d-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id.toString() == id);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw ExceptionHandle('Could not delete Product.');
    }
    existingProduct = null;
  }
}
