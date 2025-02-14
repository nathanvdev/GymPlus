class Expense {
  int id;
  String name;
  String description;
  double amount;
  String supplier;
  int status;
  String date;
  int adminID;


  Expense({
    this.id = -1,
    required this.name,
    required this.description,
    required this.amount,
    required this.supplier,
    required this.status,
    required this.date,
    required this.adminID,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    for (var key in json.keys) {
      if (json[key] == null) {
        json[key] = '';
      }
    }
    return Expense(
      id: json['id'].toInt(),
      name: json['product_name'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      supplier: json['supplier'],
      status: json['status'].toInt(),
      date: json['date'],
      adminID: json['admin_member_id'].toInt(),
    );
  }

}