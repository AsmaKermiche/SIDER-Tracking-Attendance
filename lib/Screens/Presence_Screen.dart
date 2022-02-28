import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stage/CalendarScreenProvider.dart';
import 'package:stage/Screens/Calendar_Screen.dart';
import 'package:stage/Screens/Home_Screen.dart';
import 'package:http/http.dart' as http;


import '../constants.dart';
import '../name.dart';

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({Key? key,required this.matricule ,required this.iddep}) : super(key: key);
  final int? iddep;
  final String? matricule;
 /*const PresenceScreen({Key? key,required this.iddep}) : super(key: key);
  final int? iddep;*/

  @override
  _PresenceScreenState createState() => _PresenceScreenState();
}
String? matricule;
String? name;

Future<void> fetchName() async {
  var url = "http://192.168.1.6/flutter_login_signup/name.php";

  var data = {'matricule': matricule};

  var response = await http.post(Uri.parse(url), body: json.encode(data));

  if (response.statusCode == 200) {
    print(response.statusCode);

    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    List<Name> names = items.map<Name>((json) {
      return Name.fromJson(json);
    }).toList();
    name = names.first.name;
  } else {
    throw Exception('Failed to load data from Server.');
  }
}
class _PresenceScreenState extends State<PresenceScreen> {
  @override
  Widget build(BuildContext context) {
    matricule = widget.matricule;
    fetchName();
    var now = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm').format(now);
    String formattedDate = formatter.format(now);
    return ChangeNotifierProvider<CalendarScreenProvider>(
        create: (context) => CalendarScreenProvider(),
        child: Builder(builder: (context)
    {
      return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bonjour, ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 5,),
                  Text(
                      "Asma Kermiche",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Hero(
                tag: '1',
                child: Text(
                  formattedDate,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Hero(
                tag: '2',
                child: Text(
                  formattedTime,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Image.asset("assets/here.png", scale: 0.5
                ),
              ),
              SizedBox(height: 40),
              Container(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: red)),
                    color: red,
                    textColor: Colors.white,
                    child: Text("Considère-moi présent",
                        style: TextStyle(fontSize: 20)),
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(matricule: widget.matricule,iddep: widget.iddep, ),),);

                    },
                  )),
            ],
          ),
        ),
      );
    }
        ),
    );

  }
}
