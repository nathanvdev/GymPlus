import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';

class LoginProvider extends ChangeNotifier {
  final dio = Dio();
  late User user;

  login(String username, String password) async {
    try {
      final response = await dio.post(
        'http://localhost:3569/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        user = User.fromJson(response.data["userExist"]);
        notifyListeners();
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

  logout() {
    user = User(
      username: '',
      password: '',
      memberId: 0,
      createdAt: '',
      updatedAt: '',
      dateOfEmployment: '',
      employmentStatus: '',
      rol: '',
    );
    notifyListeners();
  }

  setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }

  getUserId() {
    return user.memberId;
  }

  getUsername() {
    return user.username;
  }

  getRol() {
    return user.rol;
  }

  getEmploymentStatus() {
    return user.employmentStatus;
  }

  getDateOfEmployment() {
    return user.dateOfEmployment;
  }

  getCreatedAt() {
    return user.createdAt;
  }

  getUpdatedAt() {
    return user.updatedAt;
  }
}
