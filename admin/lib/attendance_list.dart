import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Employee.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({Key? key}) : super(key: key);

  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {

 String date = "29-10-2021";

  Future<void> fetchLatLong() async {
    var url = "http://192.168.1.179/flutter_login_signup/list.php";
    var data = {'date': date};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Employee> emp = items.map<Employee>((json) {
        return Employee.fromJson(json);
      }).toList();
      print(emp);

    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          child: Text("asma"),
          onPressed: () {
    fetchLatLong();}
    ),
    ),
    );
    }
}

