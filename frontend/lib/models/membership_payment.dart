class MembershipPayment{

  String memberId;
  String membershipPlan;
  String billingQuantity;
  String billingCycle;
  String initialPaymentDate;
  String nextPaymentDate;
  String subtotal;
  String discounts;
  String discountsDescription;
  String total;
  String paymentMethod;
  String cash;
  String change;
  String paymentStatus;
  String paymentReference;
  String adminMemberId;

  MembershipPayment({
    required this.memberId,
    required this.membershipPlan,
    required this.billingQuantity,
    required this.billingCycle,
    required this.initialPaymentDate,
    required this.nextPaymentDate,
    required this.subtotal,
    required this.discounts,
    required this.discountsDescription,
    required this.total,
    required this.paymentMethod,
    required this.cash,
    required this.change,
    required this.paymentStatus,
    required this.paymentReference,
    required this.adminMemberId,
  });

  factory MembershipPayment.fromJson(Map<String, dynamic> json) {
    return MembershipPayment(
      memberId: json['member_id'],
      membershipPlan: json['membership_plan'],
      billingQuantity: json['billing_quantity'],
      billingCycle: json['billing_cycle'],
      initialPaymentDate: json['initialpaymentdate'],
      nextPaymentDate: json['nextpaymentdate'],
      subtotal: json['subtotal'],
      discounts: json['discounts'],
      discountsDescription: json['discounts_description'],
      total: json['total'],
      paymentMethod: json['payment_method'],
      cash: json['cash'],
      change: json['changue'],
      paymentStatus: json['payment_status'],
      paymentReference: json['payment_reference'],
      adminMemberId: json['admin_member_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'membership_plan': membershipPlan,
      'billing_quantity': billingQuantity,
      'billing_cycle': billingCycle,
      'initialpaymentdate': initialPaymentDate,
      'nextpaymentdate': nextPaymentDate,
      'subtotal': subtotal,
      'discounts': discounts,
      'discounts_description': discountsDescription,
      'total': total,
      'payment_method': paymentMethod,
      'cash': cash,
      'change': change,
      'payment_status': paymentStatus,
      'payment_reference': paymentReference,
      'admin_member_id': adminMemberId,
    };
  }
}