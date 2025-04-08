
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/member.dart';

class ProfileviewProvider extends ChangeNotifier{
  final dio = Dio();
  FullMember member = FullMember.createEmpty();


  Future<void> refresh(int id, context) async {
    try {
      final response = await dio.get('http://localhost:3569/member/full/$id');
      if (response.statusCode == 200) {
        member = FullMember.fromJson(response.data);
        notifyListeners();
        return;
      }else{
        AlertDialog(
          title: const Text('Error'),
          content: Text('statusCode: ${response.statusCode}\nmessage: ${response.data}'),
          actions: [
            TextButton(
              onPressed: () {
                if (context != null) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
      return;
    } catch (e) {
      return;
    }
  }
}