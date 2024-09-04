class Sale {
  String id;
  String total;
  String date;
  String autorizedBy;

  Sale({
    required this.id,
    required this.total,
    required this.date,
    required this.autorizedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'date': date,
      'autorizedBy': autorizedBy,
    };
  }
}