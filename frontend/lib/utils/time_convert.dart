import 'package:intl/intl.dart';

String convertToGuatemalaTime(String utcDateTime) {
  DateTime dateTime = DateTime.parse(utcDateTime).toUtc();
  DateTime guatemalaTime = dateTime.subtract(const Duration(hours: 6));
  return DateFormat('yyyy-MM-ddTHH:mm:ss').format(guatemalaTime);
}