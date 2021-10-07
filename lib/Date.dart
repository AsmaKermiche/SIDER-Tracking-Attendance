import 'package:intl/intl.dart';
//datefile
class Date {
 String date;

  Date({
    required this.date,

  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      date: json['date'],
    );
  }
}

