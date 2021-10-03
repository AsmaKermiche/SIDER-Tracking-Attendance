import 'package:intl/intl.dart';

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

