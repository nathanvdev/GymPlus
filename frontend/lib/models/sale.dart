class Sale {
  String id;
  String total;
  String date;
  String status;
  String autorizedBy;

  Sale({
    required this.id,
    required this.total,
    required this.date,
    required this.status,
    required this.autorizedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'date': date,
      'status': status,
      'autorizedBy': autorizedBy,
    };
  }
}