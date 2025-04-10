import 'package:frontend/utils/time_convert.dart';

class Transaction{
  String descripcion;
  double debito;
  double credito;
  double disponible;
  double reserva;
  double total;
  String fecha;

  Transaction({
    this.descripcion = '',
    this.debito = 0.0,
    this.credito = 0.0,
    this.disponible = 0.0,
    this.reserva = 0.0,
    this.total = 0.0,
    this.fecha = '',
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      descripcion: json['description']?.toString() ?? '',
      debito: json['Debito'] != null ? double.tryParse(json['Debito'].toString()) ?? 0.0 : 0.0,
      credito: json['Credito'] != null ? double.tryParse(json['Credito'].toString()) ?? 0.0 : 0.0,
      disponible: json['Disponible'] != null ? double.tryParse(json['Disponible'].toString()) ?? 0.0 : 0.0,
      reserva: json['Reserva'] != null ? double.tryParse(json['Reserva'].toString()) ?? 0.0 : 0.0,
      total: json['Total'] != null ? double.tryParse(json['Total'].toString()) ?? 0.0 : 0.0,
      fecha: convertToGuatemalaTime(json['createdAt']),
    );
  }
}

