import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/Screens/Presence_Screen.dart';

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
      Text('Products Page', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      Text('Cart Page', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bottom Navigation'),
      ),
      body: Container(
          child: Center(
              child: _widgetList.elementAt(_selectedIndex) // here we show all screen's content
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        //here create all navigation items
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Products')),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Cart')),
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