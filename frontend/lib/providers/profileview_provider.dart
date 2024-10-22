
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/member.dart';

class ProfileviewProvider extends ChangeNotifier{
  FullMember member = FullMember.createEmpty();


  Future<void> refresh(int id) async {
    final dio = Dio();
    try {
      final response = await dio.get('http://localhost:3569/member/full/$id');
      if (response.statusCode == 200) {
        member = FullMember.fromJson(response.data);
        notifyListeners();
      }

    } catch (e) {
      return;
    }
  }
}