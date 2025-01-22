class Sale {
  String id;
  String total;
  String date;
  String hour;
  String autorizedBy;

  Sale({
    required this.id,
    required this.total,
    required this.date,
    required this.hour,
    required this.autorizedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'date': date,
      'hour': hour,
      'autorizedBy': autorizedBy,
    };
  }
}