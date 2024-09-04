import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/sale.dart';

class SalesProvider with ChangeNotifier {
  final dio = Dio();
  List<Sale> saleList = [];
  List<Sale> filteredSaleList = [];

  Future<void> refresh() async {
    try {
      final response = await dio.get('http://localhost:3569/sale/getall');
      final List<dynamic> saleListData = response.data['sales'];

      for (var element in saleListData) {
        for (var key in element.keys) {
          if (element[key] == null) {
            element[key] = '';
          }
        }
      }

      saleList.clear();
      for (var element in saleListData) {
        var newSale = Sale(
          id: element['id'].toString(),
          total: element['total'].toString(),
          date: element['createdAt'].toString().substring(0, 10),
          autorizedBy: element['autorizedBy'].toString(),
        );
        saleList.add(newSale);
      }
      filteredSaleList.clear();
      filteredSaleList.addAll(saleList);
      notifyListeners();
      return;
    } catch (e) {
      return;
    }
  }

  filtringSales(String filter) {
    if (filter.isEmpty) {
      filteredSaleList.clear();
      filteredSaleList.addAll(saleList);
      notifyListeners();
      return;
    } else {
      filteredSaleList.clear();
      for (var sale in saleList) {
        if (sale.id.toLowerCase().contains(filter.toLowerCase())) {
          filteredSaleList.add(sale);
        }
      }
      notifyListeners();
      return;
    }
  }

  deleteSale(String id) async {
    try {
      final dio = Dio();
      final response = await dio.delete('http://localhost:3569/sale/delete/$id');
      //TODO
      if (response.statusCode == 200) {
        refresh();
        notifyListeners();
        
      }
      return;
    } catch (e) {
      return;
    }
  }
}