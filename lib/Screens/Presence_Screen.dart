import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stage/CalendarScreenProvider.dart';
import 'package:stage/Screens/Calendar_Screen.dart';
import 'package:stage/Screens/Home_Screen.dart';

import '../constants.dart';

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({Key? key,required this.matricule ,required this.iddep}) : super(key: key);
  final int? iddep;
  final String? matricule;
 /*const PresenceScreen({Key? key,required this.iddep}) : super(key: key);
  final int? iddep;*/

  @override
  _PresenceScreenState createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  @override
  Widget build(BuildContext context) {
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
