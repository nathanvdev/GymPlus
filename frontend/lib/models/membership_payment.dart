class MembershipPayment{
  late int id;
  int memberId;
  int membershipPlan;
  int billingQuantity;
  int billingCycle;
  String initialPaymentDate;
  String nextPaymentDate;
  double subtotal;
  double discounts;
  String discountsDescription;
  double total;
  int paymentMethod;
  double cash;
  double change;
  int paymentStatus;
  String paymentReference;
  int adminMemberId;
   String createdAt;
   String updatedAt;
   String name;
   String lastName;

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
    this.createdAt = '--/--/----',
    this.updatedAt = '--/--/----',
    this.name = '',
    this.lastName = '',
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