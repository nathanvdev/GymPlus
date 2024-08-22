import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/member.dart';

class MemberTableProvider extends ChangeNotifier {
  final dio = Dio();
  List<Member> memberList = [];
  List<Member> filtredMemberList = [];

  Future<void> refresh() async {
    try {
      final response = await dio.get('http://localhost:3569/member/get');
      final List<dynamic> memberListData = response.data['members'];
      memberList.clear();

      for (var element in memberListData) {
        for (var key in element.keys) {
          if (element[key] == null) {
            element[key] = '';
          }
        }
      }

      for (var element in memberListData) {
        var newMember = Member(
          id: element['id'],
          name: element['name'],
          lastname: element['lastName'],
          membershipStatus: element['membershipStatus'],
          lastPaymentDate: element['lastPaymentDate'],
          nextPaymentDate: element['nextPaymentDate'],
          lastVisit: element['lastVisit'],
          activeDays: element['activeDays'].toString(),
        );
        memberList.add(newMember);
      }
      filtredMemberList.clear();
      filtredMemberList.addAll(memberList);
      notifyListeners();
    } catch (e) {
      return;
    }

  }

  filtringMembers(String filter) {
    if (filter.isEmpty) {
      filtredMemberList.clear();
      filtredMemberList.addAll(memberList);
      notifyListeners();
      return;
    } else {
      filtredMemberList.clear();
      for (var member in memberList) {
        if (member.name.toLowerCase().contains(filter.toLowerCase()) ||
            member.lastname.toLowerCase().contains(filter.toLowerCase())) {
          filtredMemberList.add(member);
        }
      }
      notifyListeners();
    }
  }

  getMemberNameById(int id){
    String name = memberList.firstWhere((element) => element.id == id).name;
    String lastName = memberList.firstWhere((element) => element.id == id).lastname;
    // return memberList.firstWhere((element) => element.id == id).name;
    return "$name $lastName";
  }

}


class MemberSelectedProvider extends ChangeNotifier {
  int _selectedMemberId = -1;

  setSelectedMemberId(int memberId) {
    _selectedMemberId = memberId;
    notifyListeners();
  }

  getSelectedMemberId() {
    return _selectedMemberId;
  }

}