
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/membership_payment.dart';

class PaymentsProvider extends ChangeNotifier {
  final List<MembershipPayment> paymentList = [];
  final List<MembershipPayment> filteredPaymentList = [];
  final dio = Dio();

  Future<void> refresh() async {
    paymentList.clear();
    filteredPaymentList.clear();
    try {
      final response = await dio.get('http://localhost:3569/payment/getall');
      final List<dynamic> paymentListData = response.data['payments'];

      for (var element in paymentListData) {
        for (var key in element.keys) {
          if (element[key] == null) {
            element[key] = '';
          }
        }
      }

      for (var element in paymentListData) {
        if(element['subtotal'] == null) {
          element['subtotal'] = 0.0;
        }
        if(element['discounts'] == null) {
          element['discounts'] = 0.0;
        }
        if(element['total'] == null) {
          element['total'] = 0.0;
        }
        if(element['cash'] == null) {
          element['cash'] = 0.0;
        }
        if(element['changue'] == null) {
          element['changue'] = 0.0;
        }

        var newPayment = MembershipPayment(
          memberId: element['member_id'],
          membershipPlan: element['membership_plan'],
          billingQuantity: element['billing_quantity'],
          billingCycle: element['billing_cycle'],
          initialPaymentDate: element['initialpaymentdate'],
          nextPaymentDate: element['nextpaymentdate'],
          subtotal: element['subtotal'].toDouble(),
          discounts: element['discounts'].toDouble(),
          discountsDescription: element['discounts_description'],
          total: element['total'].toDouble(),
          paymentMethod: element['payment_method'],
          cash: element['cash'].toDouble(),
          change: element['changue'].toDouble(),
          paymentStatus: element['payment_status'],
          paymentReference: element['payment_reference'],
          adminMemberId: element['admin_member_id'],
        );
        newPayment.id = element['id'];
        newPayment.name = element['member_name'];
        newPayment.lastName = element['member_lastname'];
        newPayment.createdAt = element['createdAt'].substring(0, 10);
        newPayment.updatedAt = element['updatedAt'].substring(0, 10);
        paymentList.add(newPayment);
      }
      filteredPaymentList.addAll(paymentList);
      notifyListeners();
    } catch (e) {
      return;
    }
    notifyListeners();
  }

  filtringPayments(String filter) {
    if (filter.isEmpty) {
      filteredPaymentList.clear();
      filteredPaymentList.addAll(paymentList);
      notifyListeners();
      return;
    } else {
      filteredPaymentList.clear();
      for (var payment in paymentList) {
        if (payment.memberId.toString().toLowerCase().contains(filter.toLowerCase())) {
          filteredPaymentList.add(payment);
        }
      }
      notifyListeners();
    }
  }
}

