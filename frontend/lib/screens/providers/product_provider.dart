import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final dio = Dio();
  List<Product> productList = [];
  List<Product> filtredProductList = [];

  Future<void> refresh() async {
    try {
      final response = await dio.get('http://localhost:3569/product/getall');
      final List<dynamic> productListData = response.data['products'];
      productList.clear();

      for (var element in productListData) {
        if (element['imageurl'] != null) {
          String imageurl = element['imageurl'].toString();
          imageurl = imageurl.replaceAll('\\', '/');
          element['imageurl'] = imageurl;
        }
        for (var key in element.keys) {
          if (element[key] == null) {
            element[key] = '';
          }
        }
      }

      for (var element in productListData) {
        var newProduct = Product(
          id: element['id'].toString(),
          name: element['name'],
          stock: element['stock'].toString(),
          price: element['price'].toString(),
          imageurl: element['imageurl'],
        );
        productList.add(newProduct);
      }
      filtredProductList.clear();
      filtredProductList.addAll(productList);
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  filtringProducts(String filter) {
    if (filter.isEmpty) {
      filtredProductList.clear();
      filtredProductList.addAll(productList);
      notifyListeners();
      return;
    } else {
      filtredProductList.clear();
      for (var product in productList) {
        if (product.name.toLowerCase().contains(filter.toLowerCase())) {
          filtredProductList.add(product);
        }
      }
      notifyListeners();
      return;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await dio.delete('http://localhost:3569/product/delete/$id');
      refresh();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await dio.post('http://localhost:3569/product/add',
          data: product.toJson());
      refresh();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await dio.put('http://localhost:3569/product/update/${product.id}',
          data: product.toJson());
      refresh();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  getProductById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }
}
