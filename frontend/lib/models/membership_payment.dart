class MembershipPayment{
  int id;
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
    required this.id,
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

    for (var key in json.keys) {
      if (json[key] == null ) {
        json[key] = '';
      }
    }

    return MembershipPayment(
      id: json['id'],
      memberId: json['member_id'],
      membershipPlan: json['membership_plan'],
      billingQuantity: json['billing_quantity'],
      billingCycle: json['billing_cycle'],
      initialPaymentDate: json['initialpaymentdate'],
      nextPaymentDate: json['nextpaymentdate'],
      subtotal: json['subtotal'] != null ? double.parse(json['subtotal'].toString()) : 0.00,
      discounts: json['discounts'] != null ? double.parse(json['discounts'].toString()) : 0.00,
      discountsDescription: json['discounts_description'],
      total: json['total'] != null ? double.parse(json['total'].toString()) : 0.00,
      paymentMethod: json['payment_method'],
      cash: json['cash'] != null ? double.parse(json['cash'].toString()) : 0.00,
      change: json['changue'] != null ? double.parse(json['changue'].toString()) : 0.00,
      paymentStatus: json['payment_status'],
      paymentReference: json['payment_reference'],
      adminMemberId: json['admin_member_id'],
      createdAt: json['createdAt'].substring(0, 10),
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