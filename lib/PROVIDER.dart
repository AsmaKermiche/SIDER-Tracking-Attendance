/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ScreenProvider extends ChangeNotifier {

  Future<void> fetchDates(String matricule) async {
    var url = "http://192.168.1.8/flutter_login_signup/date.php";

    var data = {'matricule': matricule.toString()};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Date> date = items.map<Date>((json) {
        return Date.fromJson(json);
      }).toList();
      List<dynamic> listValues =[];
      date.forEach((element) {
        if(!listValues.contains(element.date))
          listValues.add(element.date);
      });

    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  List<DateTime> get presentDates => dateTimeList;


}
*/
