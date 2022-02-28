import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/Screens/Calendar_Screen.dart';
import 'package:stage/Screens/Presence_Screen.dart';

import '../constants.dart';

class NavBar extends StatefulWidget {
  final int? iddep;
  final String? matricule;
   NavBar({Key? key,required this.matricule, required this.iddep})
      : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    final _widgetList = [
      PresenceScreen(matricule: widget.matricule, iddep: widget.iddep),
      CalendarPage(matricule: widget.matricule),
    ];
    return Scaffold(
      body: Container(
          child: Center(
              child: _widgetList.elementAt(_selectedIndex) // here we show all screen's content
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: pink,
        //here create all navigation items
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.check,color:red), title: Text('Check-in',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today,color: red,), title: Text('Calendrier',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        ],
        currentIndex: _selectedIndex,
        onTap: _navigateFunction,
      ),
    );
  }

  _navigateFunction(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}