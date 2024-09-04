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

      productList.clear();
      for (var element in productListData) {
        var newProduct = Product(
          id: element['id'].toString(),
          name: element['name'],
          stock: element['stock'].toString(),
          price: element['price'].toStringAsFixed(2),
          imageurl: element['imageurl'],
        );
        productList.add(newProduct);
      }
      filtredProductList.clear();
      filtredProductList.addAll(productList);
      notifyListeners();
      return;
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


  getProductById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }

  getProduct() {
    return productList;
  }

  deleteProduct(id){
    productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class ItemCart{
  int id;
  int quantity;
  double subtotal;

  ItemCart(this.id, this.quantity, {this.subtotal = 0});

  setSubtotal(double price){
    subtotal = quantity * price;
    return subtotal;
  }
}


class CartItemsProvider extends ChangeNotifier{
  List<ItemCart> cartItems = [];

  void addProduct(int id, double price) {
    cartItems.add(ItemCart(id, 1));
    cartItems.last.setSubtotal(price);
    notifyListeners();
  }

  void removeProduct(int id) {
    cartItems.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clear() {
    cartItems.clear();
    notifyListeners();
  }

  List<ItemCart> getProducts() {
    return cartItems;
  }

  String getProductById(int id) {
    try {
      return cartItems.firstWhere((element) => element.id == id).toString();
    } catch (e) {
      throw Exception('Product with id $id not found');
    }
  }

}