import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final dio = Dio();
  List<Expense> expenseList = [];
  List<Expense> filteredExpenseList = [];

  Future refresh() async {
    try {
      final response = await dio.get('http://localhost:3569/expense/getall');

      expenseList.clear();
      for (var element in response.data['expenses']) {
        var newExpense = Expense.fromJson(element);
        expenseList.add(newExpense);
      }
      filteredExpenseList.clear();
      filteredExpenseList.addAll(expenseList);
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

  Future addExpense(Expense expense) async {
    try {
      final response =
          await dio.post('http://localhost:3569/expense/add', data: {
        'product_name': expense.name,
        'description': expense.description,
        'amount': expense.amount,
        'supplier': expense.supplier,
        'status': expense.status,
        'date': expense.date,
        'admin_member_id': expense.adminID,
      });

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

  Future deleteExpense(int id) async {
    try {
      final response = await dio.delete('http://localhost:3569/expense/delete/$id');
      if (response.statusCode == 200) {
        return jsonEncode({
          'statusCode': response.statusCode,
        });
      }
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

  filtringExpenses(String filter) {
    if (filter.isEmpty) {
      filteredExpenseList.clear();
      filteredExpenseList.addAll(expenseList);
      notifyListeners();
      return;
    } else {
      filteredExpenseList.clear();
      for (var expense in expenseList) {
        if (expense.name.toLowerCase().contains(filter.toLowerCase())) {
          filteredExpenseList.add(expense);
        }else if (expense.description.toLowerCase().contains(filter.toLowerCase())) {
          filteredExpenseList.add(expense);}
          else if(expense.supplier.toLowerCase().contains(filter.toLowerCase())){
            filteredExpenseList.add(expense);
          }
      }
      notifyListeners();
      return;
    }
  }

  Future getExpense(int id) async {
    try {
      final response = await dio.get('http://localhost:3569/expense/get/$id');
      if (response.statusCode == 200) {
        final expense = Expense.fromJson(response.data['expense']);
        return jsonEncode({
          'statusCode': response.statusCode,
          'id': expense.id,
          'name': expense.name,
          'description': expense.description,
          'amount': expense.amount,
          'supplier': expense.supplier,
          'status': expense.status,
          'date': expense.date,
          'adminID': expense.adminID,
        });
      }
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

  Future updateExpense(Expense expense) async {
    try {
      final response = await dio.put('http://localhost:3569/expense/edit/${expense.id}', data: {
        'product_name': expense.name,
        'description': expense.description,
        'amount': expense.amount.toDouble(),
        'supplier': expense.supplier,
        'status': expense.status.toInt(),
        'date': expense.date,
        'admin_member_id': expense.adminID.toInt(),
      });
  
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
