import 'package:flutter/material.dart';
import 'package:stage/Screens/Home_Screen.dart';
import 'package:stage/Screens/Presence_Screen.dart';
import 'package:stage/Screens/Register_Screen.dart';

import 'Screens/iidep.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IDDEP(),
      //home: SignupScreen(),

    );
  }
}

