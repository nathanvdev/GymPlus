class Measurement {
  int id;
  int memberId;
  double height;
  double weight;
  double imc;
  double arm;
  double chest;
  double abdomen;
  double gluteus;
  double thigh;
  String createdAt;

  Measurement({
    required this.id,
    required this.memberId,
    required this.height,
    required this.weight,
    required this.imc,
    required this.arm,
    required this.chest,
    required this.abdomen,
    required this.gluteus,
    required this.thigh,
    required this.createdAt,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {


    for (var key in json.keys) {
      if (json[key] == null || json[key] == '') {
        json[key] = 0.00;
        }
      }

    return Measurement(
      id: json['id'],
      memberId: json['member_id'],
      height: json['height'] != null ? double.parse(json['height'].toString()) : 0.00,
      weight: json['weight'] != null ? double.parse(json['weight'].toString()) : 0.00,
      imc: json['imc'] != null ? double.parse(json['imc'].toString()) : 0.00,
      arm: json['arm'] != null ? double.parse(json['arm'].toString()) : 0.00,
      chest: json['chest'] != null ? double.parse(json['chest'].toString()) : 0.00,
      abdomen: json['abdomen'] != null ? double.parse(json['abdomen'].toString()) : 0.00,
      gluteus: json['gluteus'] != null ? double.parse(json['gluteus'].toString()) : 0.00,
      thigh: json['thigh'] != null ? double.parse(json['thigh'].toString()) : 0.00,
      createdAt: json['createdAt'],
    );
  }
}