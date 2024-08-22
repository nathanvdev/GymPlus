import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';

class LoginProvider extends ChangeNotifier {
  final dio = Dio();
  
  var user = User(
    memberId: 0,
    username: 'none',
    password: '',
    rol: '',
    employmentStatus: '',
    dateOfEmployment: '',
    createdAt: '',
    updatedAt: '',
  );

  login(String username, String password) async {
    try {
      final response = await dio.get(
        'http://localhost:3569/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        return null;
      }

      user = User.fromJson(response.data);
      notifyListeners();

      return user;
    } catch (e) {
      return null;
    }
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
