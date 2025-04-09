import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/transaction.dart';
import 'dart:convert';

class TransactionProvider extends ChangeNotifier {
  final dio = Dio();
  List<Transaction> transactionList = [];
  
  Future refresh() async {
    try {
      final response =
          await dio.get('http://localhost:3569/transaction/getall');

      transactionList.clear();
      for (var element in response.data['transactions']) {
        var newTransaction = Transaction.fromJson(element);
        transactionList.add(newTransaction);
      }

      notifyListeners();
      return jsonEncode({
        'statusCode': response.statusCode,
      });
    } on DioException catch (e) {
      return jsonEncode({
        'statusCode': e.response?.statusCode ?? 500,
        'msg': e.response?.data['msg'] ?? 'Error en el servidor',
      });
    } catch (e) {
      return jsonEncode({
        'statusCode': 500,
        'msg': 'An unexpected error occurred',
      });
    }
  }
}