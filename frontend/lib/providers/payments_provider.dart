import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/membership_payment.dart';

class PaymentsProvider extends ChangeNotifier {
  final List<MembershipPayment> paymentList = [];
  final List<MembershipPayment> filteredPaymentList = [];
  final dio = Dio();

  Future<void> refresh() async {
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

      paymentList.clear();
      for (var element in paymentListData) {
        if (element['subtotal'] == null) {
          element['subtotal'] = 0.0;
        }
        if (element['discounts'] == null) {
          element['discounts'] = 0.0;
        }
        if (element['total'] == null) {
          element['total'] = 0.0;
        }
        if (element['cash'] == null) {
          element['cash'] = 0.0;
        }
        if (element['changue'] == null) {}
        element['changue'] = 0.0;

        var newPayment = MembershipPayment(
          id: element['id'],
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
      filteredPaymentList.clear();
      filteredPaymentList.addAll(paymentList);
      notifyListeners();
      return;
    } catch (e) {
      return;
    }
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
        if (filter.toLowerCase() == 'pendiente') {
          if (payment.paymentStatus == 2) {
            filteredPaymentList.add(payment);
          }
          
        }else if (filter.toLowerCase() == 'pagado') {
          if (payment.paymentStatus == 1) {
            filteredPaymentList.add(payment);
          }
        } else if (filter.toLowerCase() == 'dia') {
          if (payment.billingCycle == 1) {
            filteredPaymentList.add(payment);
          }
        } else if (filter.toLowerCase() == 'semana') {
          if (payment.billingCycle == 2) {
            filteredPaymentList.add(payment);
          }
        } else if (filter.toLowerCase() == 'mes') {
          if (payment.billingCycle == 3) {
            filteredPaymentList.add(payment);
          }
        } else if (filter.toLowerCase() == 'año') {
          if (payment.billingCycle == 4) {
            filteredPaymentList.add(payment);
          }
        } else
        if (payment.name.toLowerCase().contains(filter.toLowerCase()) ||
            payment.lastName.toLowerCase().contains(filter.toLowerCase()) ||
            payment.initialPaymentDate.toLowerCase().contains(filter.toLowerCase()) ||
            payment.nextPaymentDate.toLowerCase().contains(filter.toLowerCase()) ||
            payment.paymentReference.toLowerCase().contains(filter.toLowerCase()) ||
            payment.createdAt.toLowerCase().contains(filter.toLowerCase()) ||
            payment.billingQuantity.toString().contains(filter) ||
            payment.id.toString().contains(filter)) {
          filteredPaymentList.add(payment);
        }
      }
      notifyListeners();
    }
  }

  emptyMembershipPaymeny() {
    var newPayment = MembershipPayment(
      id: 0,
      memberId: 0,
      membershipPlan: 0,
      billingQuantity: 0,
      billingCycle: 0,
      initialPaymentDate: '',
      nextPaymentDate: '',
      subtotal: 0.0,
      discounts: 0.0,
      discountsDescription: '',
      total: 0.0,
      paymentMethod: 0,
      cash: 0.0,
      change: 0.0,
      paymentStatus: 0,
      paymentReference: '',
      adminMemberId: 0,
    );
    return newPayment;
  }

  getPaymentById(int id) async {
    try {
      final response =
          await dio.get('http://localhost:3569/payment/getbyid/$id');
      final element = response.data['payment'];
      if (element['subtotal'] == null) {
        element['subtotal'] = 0.0;
      }
      if (element['discounts'] == null) {
        element['discounts'] = 0.0;
      }
      if (element['total'] == null) {
        element['total'] = 0.0;
      }
      if (element['cash'] == null) {
        element['cash'] = 0.0;
      }
      if (element['changue'] == null) {
        element['changue'] = 0.0;
      }
      for (var key in element.keys) {
        if (element[key] == null) {
          element[key] = '';
        }
      }
      var newPayment = MembershipPayment(
        id: element['id'],
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

      return newPayment;
    } catch (e) {
      return;
    }
  }
}
