import 'package:flutter/material.dart';
const red = const Color(0xFFfa3d3b);
const pink = const Color(0xFFfad0d1);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(9.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: red, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(9)),
  ),
);
